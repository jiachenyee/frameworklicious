//
//  MenuView.swift
//  frameworkAR
//
//  Created by Safik Widiantoro on 30/06/23.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                NavigationLink(destination: SpotLightViewContainer().edgesIgnoringSafeArea(.all)) {
                    CardView(title: "Spotlight", imageName: "💡")
                }
                
                NavigationLink(destination: ObjectARViewContainer().edgesIgnoringSafeArea(.all)) {
                    CardView(title: "Object AR", imageName: "🤖")
                }
                
                NavigationLink(destination: ARViewContainer().edgesIgnoringSafeArea(.all)) {
                    CardView(title: "Replace Image", imageName: "🎸")
                }
            }
            .padding()
        }
    }
}

struct CardView: View {
    var title: String
    var imageName: String
    
    var body: some View {
        VStack {
            Text(imageName)
                .font(.system(size: 80))
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
