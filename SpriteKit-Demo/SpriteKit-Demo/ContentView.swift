//
//  ContentView.swift
//  SpriteKit-Demo
//
//  Created by Jia Chen Yee on 09/06/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Lol") {
                print("LOL")
            }
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
