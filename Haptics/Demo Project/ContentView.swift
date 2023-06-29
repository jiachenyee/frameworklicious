//
//  ContentView.swift
//  Demo Project
//
//  Created by Jia Chen Yee on 12/06/23.
//

import SwiftUI
import CoreHaptics

enum Destination {
    case case1View
    case case2View
    case case3View
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
                    
//                    NavigationLink(value: Destination.case3View) {
//                        Text("Augmented Reality")
//                    }
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
