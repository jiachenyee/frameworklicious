//
//  ContentView.swift
//  Demo Project
//
//  Created by Gerson Janhuel on 25/06/23.
//

import SwiftUI
import CoreHaptics

enum Destination {
    case case1View
    case case2View
    case case3View
    case case4View
}

struct ContentView: View {
    @StateObject var hapticsManager = HapticsManager()
    
    var body: some View {
        NavigationStack {
            Group {
                
                List {
                    NavigationLink(value: Destination.case1View) {
                        Text("Custom Haptics Samples")
                    }
                    
                    NavigationLink(value: Destination.case2View) {
                        Text("Physical Contact")
                    }
                    
                    NavigationLink(value: Destination.case3View) {
                        Text("AR Lamborghini")
                    }
                    
                    NavigationLink(value: Destination.case4View) {
                        Text("AR Bounce")
                    }
                }
                
            }
            .navigationTitle("Demo Menu")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .case1View:
                    Case1View()
                case .case2View:
                    Case2View()
                case .case3View:
                    Case3View()
                case .case4View:
                    Case4View()
                
                }
                
                
            }
        }
        .environmentObject(hapticsManager)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
