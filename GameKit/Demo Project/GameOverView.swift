//
//  GameOverView.swift
//  Demo Project
//
//  Created by Gerson Janhuel on 24/06/23.
//

import SwiftUI

struct GameOverView: View {
    @ObservedObject var matchManager: MatchManager
//    @State var isLocalPlayerWin: Bool = true
    
    var body: some View {
        ZStack {
            Color("custom-purple")
                .ignoresSafeArea(.all)
            
            VStack {
                if matchManager.isDraw == true {
                    Text("Draw!")
                        .font(.system(size: 100).bold().italic())
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray )
                    
                } else {
                    Text((matchManager.isLocalPlayerWin) ? "You WIN!" : "You LOSE!")
                        .font(.system(size: 100).bold().italic())
                        .multilineTextAlignment(.center)
                        .foregroundColor((matchManager.isLocalPlayerWin) ? .green : .red )
                }
                
                
                Text("\(matchManager.tapScore) vs \(matchManager.otherPlayerScore)")
                    .font(.system(size: 40).bold().italic())
                    .foregroundColor(Color("dark-yellow"))
                
                Button {
                    matchManager.gameStatus = .setup
                } label: {
                    Text("Play Again")
                        .frame(width: 200, height: 50)
                        .font(.title.italic())
                }
                .buttonStyle(.borderedProminent)
                .padding()
                
                Button {
                    matchManager.openLeaderboard()
                } label: {
                    Text("Leaderboards")
                        .frame(width: 200, height: 50)
                        .font(.title.italic())
                }
                .buttonStyle(.borderedProminent)
                
                
            }
        }
        
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(matchManager: MatchManager())
    }
}
