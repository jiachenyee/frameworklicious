//
//  Case3View.swift
//  Demo Project
//
//  Created by Gerson Janhuel on 25/06/23.
//

import SwiftUI
import RealityKit

struct Case3View: View {
    @EnvironmentObject var hapticsManager: HapticsManager
    
    var body: some View {
        ZStack {
            ARViewContainer()
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    
                    print("Engine start!")
                    
                    hapticsManager.playHapticSample(.lamborghini)
                    
                }

        }
        .onAppear {
            hapticsManager.prepareHaptics()
        }
        .onDisappear {
            hapticsManager.engine?.stop()
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> some ARView {
        
        // setup ARView
        let arView = ARView(frame: .zero)
        
        let boxAnchor = try! AR.loadCar()
        
        arView.scene.anchors.append(boxAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

// ontap
// play sound and haptic
