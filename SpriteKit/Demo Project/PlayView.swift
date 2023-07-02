//
//  PlayView.swift
//  Rasrace
//
//  Created by Muhammad Rezky on 29/06/23.
//

import SwiftUI
import _SpriteKit_SwiftUI

struct PlayView: View {
    @ObservedObject var gameScene: GameScene
    @State private var isStarted = false
    
    init(gameScene: GameScene) {
        self.gameScene = gameScene
    }
    
    var body: some View {
        ZStack {
            if isStarted {
                ZStack{
                    SpriteView(scene: gameScene)
                        .edgesIgnoringSafeArea(.all)
                        .ignoresSafeArea()
                    
                    
                    VStack{
                        HStack {
                            Spacer()
                            Text("Score: \(gameScene.score)")
                                .foregroundColor(.black)
                                .frame(width: 100, height: 50)
                                .background(
                                    Rectangle()
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                )
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
            
            else {
                VStack {
                    Text("RasRace 🏎️")
                        .font(.largeTitle)
                    
                    Button() {
                        isStarted = true
                    }label: {
                        Text("Start Game")
                            .font(.title)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}
