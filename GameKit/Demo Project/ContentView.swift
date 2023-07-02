//
//  ContentView.swift
//  Demo Project
//
//  Created by Jia Chen Yee on 12/06/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var matchManager = MatchManager()
    
    var body: some View {
        Group {
            
            switch matchManager.gameStatus {
            case .setup:
                SetupView(matchManager: matchManager)
            case .inGame:
                InGameView(matchManager: matchManager)
            case .gameOver:
                GameOverView(matchManager: matchManager)
            }
            
        }
        .onAppear {
            matchManager.authenticateUser()
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
