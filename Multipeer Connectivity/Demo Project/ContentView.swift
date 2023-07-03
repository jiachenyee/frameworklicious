//
//  ContentView.swift
//  Demo Project
//
//  Created by Jia Chen Yee on 12/06/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, please run on other target (Host Air Hockey for ipad and Controller Air Hockey for iOS) ")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
