//
//  ContentView.swift
//  frameworkAR
//
//  Created by Safik Widiantoro on 29/06/23.
//

import SwiftUI
import RealityKit
import Combine
import AVFoundation
import ARKit

struct ContentView : View {
    var body: some View {
        MenuView()
    }
}

class Coordinator: NSObject, ARSessionDelegate {
    
    var arView: ARView?
    var cancellable: AnyCancellable?
    var imageAnchor: ARImageAnchor?
    var imageScanned: Bool = false
    var imageVisible: Bool = false
    var player: AVPlayer?
    
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        // Cek apakah ada gambar yang berhasil di-scan
        if let imageAnchor = anchors.compactMap({ $0 as? ARImageAnchor }).first {
            imageScanned = true
            self.imageAnchor = imageAnchor
            setupUI()
        }
    }
    
    
    
    func setupUI() {
        
        
        // load the video
        guard let videoURL = Bundle.main.url(forResource: "oasis", withExtension: "mov") else {
            fatalError("Unable to load the video!")
        }
        

        let player = AVPlayer(url: videoURL)
        let videoMaterial = VideoMaterial(avPlayer: player)
        
        
        let anchor = AnchorEntity(.image(group: "AR Resources", name: "oasisImage"))
        let plane = ModelEntity(mesh: MeshResource.generatePlane(width: 0.5, depth: 0.5), materials: [videoMaterial])
        
        plane.orientation = simd_quatf(angle: .pi/2, axis: [1,0,0])
        anchor.addChild(plane)
        arView?.scene.addAnchor(anchor)
        
        guard imageScanned else {
              return
          }
        
        player.play()
        
        
    }
    

}



struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        arView.session.delegate = context.coordinator
    
        context.coordinator.arView = arView
        context.coordinator.setupUI()
        
        return arView
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

//#if DEBUG
//struct ContentView_Previews : PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//#endif
