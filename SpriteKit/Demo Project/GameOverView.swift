//
//  GameOverView.swift
//  Rasrace
//
//  Created by Muhammad Rezky on 29/06/23.
//

import SwiftUI

struct GameOverView: View {
    @ObservedObject var gameScene: GameScene
    var body: some View {
        VStack {
            Text("Game Over")
                .font(.largeTitle)
                .foregroundColor(.white)
            
            Button() {
                gameScene.goToRestartScene()
            }label: {
                Text("Restart")
                    .font(.title)
            }
            .buttonStyle(.borderedProminent)
        }
        .zIndex(1)
    }
}

//struct GameOverView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameOverView()
//    }
//}
