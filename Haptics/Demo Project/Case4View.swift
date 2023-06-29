//
//  Case4View.swift
//  Demo Project
//
//  Created by Gerson Janhuel on 29/06/23.
//

import SwiftUI
import RealityKit

struct Case4View: View {
    var body: some View {
        ZStack {
            ARCollitionViewContainer()
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ARCollitionViewContainer: UIViewRepresentable {
    let hapticManager: HapticsManager = HapticsManager()
    
    
    func makeUIView(context: Context) -> some ARView {
        hapticManager.prepareHaptics()
        
        // setup ARView
        let arView = ARView(frame: .zero)
        let ballAnchor = try! AR.loadBall()
        ballAnchor.actions.ballTapped.onAction = ballTapped
        
        arView.scene.anchors.append(ballAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    func ballTapped(_ entity: Entity?) -> Void {
        print("Play haptic!!!")
        hapticManager.playBounceHaptic()
        
    }
}


