//
//  ObjectAR.swift
//  frameworkAR
//
//  Created by Safik Widiantoro on 30/06/23.
//

import SwiftUI
import RealityKit
import ARKit

//struct ObjectARView : View {
//    var body: some View {
//        return ObjectARViewContainer().edgesIgnoringSafeArea(.all)
//    }
//}

struct ObjectARViewContainer: UIViewRepresentable {

    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        let objectAnchor = try! MyScene.loadObjectScene()
        let sphere = ModelEntity(mesh: MeshResource.generateSphere(radius: 0.2), materials: [SimpleMaterial(color: .green.withAlphaComponent(0.3),roughness: .float(0), isMetallic: true)])
        
        objectAnchor.addChild(sphere)
        
        arView.scene.addAnchor(objectAnchor)
        
        return arView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
