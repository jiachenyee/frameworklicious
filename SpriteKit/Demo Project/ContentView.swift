//
//  ContentView.swift
//  Rasrace
//
//  Created by Muhammad Rezky on 22/06/23.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    @StateObject var gameScene: GameScene = GameScene(size: UIScreen.main.bounds.size)
    
    var body: some View {
        ZStack{
            PlayView(
                gameScene: gameScene
            )
        }  
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
