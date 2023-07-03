//
//  StartView.swift
//  Air Hockey
//
//  Created by Muhammad Irfan on 29/06/23.
//

import SwiftUI

struct StartView: View {
    @ObservedObject var startVM: StartViewModel = StartViewModel()
    
    var body: some View {
        VStack(spacing: 50) {
            if (startVM.gameState == .play){
                AirHockeyView(multipeerHandler: startVM.multipeerHandler, parentViewModel: startVM)
            } else {
                Text("Players")
                    .font(.title)
                    .fontWeight(.bold)
                
                HStack(spacing: 50) {
                    StartPlayerView(player: startVM.player1)
                    StartPlayerView(player: startVM.player2)
                }
                
                switch startVM.connectionStatus {
                case .waitingPlayers:
                    Button("Stop Hosting") {
                        startVM.stopHosting()
                    }
                    Text("Available Players")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            ForEach(startVM.availablePlayers) { player in
                                if (player.peerID == startVM.player1.peerID || player.peerID == startVM.player2.peerID ) {
                                    StartPlayerView(player: player, isSearching: true, isInvited: true)
                                } else {
                                    StartPlayerView(player: player, isSearching: true) {
                                        if let peerID = player.peerID {
                                            startVM.multipeerHandler.inviteAndAssignPlayer(peerID: peerID)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    
                case .notHosting:
                    Button("Start Hosting") {
                        startVM.startHosting()
                    }
                    
                case .playerComplete:
                    Button("Start Game") {
                        startVM.startGame()
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button("Stop Hosting") {
                        startVM.stopHosting()
                    }
                }
                
                
                Button("Invite Player") {
                    startVM.multipeerHandler.invitePlayerViaBrowser()
                }
            }
        }
    }
}

struct StartPlayerView: View {
    var player: Player
    var isSearching = false
    var isInvited = false
    var assignPlayer: (() -> Void)?
    
    var body: some View {
        VStack {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 150.0, height: 150.0)
                .foregroundColor(player.color)
            if (!isSearching) {
                Text("\(player.color.description) player")
            }
            if ((player.peerID) != nil) {
                Text(player.peerID!.displayName)
            } else {
                if (player.isSearching){
                    ProgressView()
                }
            }
            if (isSearching) {
                if (!isInvited){
                    Button("Invite") {
                        assignPlayer?()
                    }
                    .buttonStyle(.borderedProminent)
                } else {
                    Button("Invited"){}
                        .buttonStyle(.borderedProminent)
                        .disabled(true)
                }
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
