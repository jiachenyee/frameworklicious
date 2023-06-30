//
//  SpotLight.swift
//  frameworkAR
//
//  Created by Safik Widiantoro on 30/06/23.
//

import SwiftUI
import RealityKit
import AVFoundation
import SwiftUI
import RealityKit
import AVFoundation



class CoordinatorSpotLight {
    
    var arView: ARView?
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        
        guard let arView = arView else {
            return
        }

        let location = recognizer.location(in: arView)
        let results = arView.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal)
        
        if let result = results.first {
           
            let anchor = AnchorEntity(raycastResult: result)
            let lightEntity = SpotLight()
            lightEntity.light.color = .red
            lightEntity.light.intensity = 1000
            
            lightEntity.look(at: [0,0,0], from: [0, 0.06, 0.3], relativeTo: anchor)
            lightEntity.shadow = SpotLightComponent.Shadow()
            
            lightEntity.light.innerAngleInDegrees = 45
            lightEntity.light.outerAngleInDegrees = 60
            lightEntity.light.attenuationRadius = 10
            
            anchor.addChild(lightEntity)
            arView.scene.addAnchor(anchor)
            
        }
    }
    
}

struct SpotLightViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(CoordinatorSpotLight.handleTap)))
        arView.scene.addAnchor(try! MyScene.loadLightScene())
        context.coordinator.arView = arView
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> CoordinatorSpotLight {
        CoordinatorSpotLight()
    }
    
}
