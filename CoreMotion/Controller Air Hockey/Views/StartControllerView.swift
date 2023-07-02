//
//  StartControllerView.swift
//  Air Hockey Controller
//
//  Created by Muhammad Irfan on 29/06/23.
//

import SwiftUI

struct StartControllerView: View {
    @ObservedObject var scVM = StartControllerViewModel()
    
    var body: some View {
        VStack(spacing: 30) {
            if (scVM.gameState == .waiting){
                switch scVM.connectionStatus {
                case .notSearching:
                    Button("Join Game") {
                        scVM.joinGame()
                    }
                case .searchingHost:
                    ProgressView {
                        Text("Searching for host")
                    }
                    Button("Cancel") {
                        scVM.cancelGame()
                    }
                case .waitingHost:
                    
                    if let playerNum = scVM.playerNum {
                        Text("Player \(playerNum.rawValue)")
                            .font(.title)
                            .fontWeight(.heavy)
                    }
                    
                    ProgressView {
                        Text("Waiting for host to start the Game")
                    }
                    Button("Cancel") {
                        scVM.cancelGame()
                    }
                }
            } else {
                ControllerView(multipeerHandler: scVM.multipeerHandler, parentViewModel: scVM)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(scVM.playerColor)
    }
}

struct StartControllerView_Previews: PreviewProvider {
    static var previews: some View {
        StartControllerView()
    }
}
