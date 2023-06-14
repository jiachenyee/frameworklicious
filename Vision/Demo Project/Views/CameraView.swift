//
//  CameraView.swift
//  Demo Project
//
//  Created by Jia Chen Yee on 14/06/23.
//

import Foundation
import UIKit
import SwiftUI
import Vision

struct CameraView: UIViewRepresentable {
    @Binding var detectedPoints: [VNRecognizedPointKey: CGPoint]

    func makeUIView(context: Context) -> CameraPreview {
        let cameraPreview = CameraPreview()
        cameraPreview.detectedPointsCallback = { points in
            DispatchQueue.main.async {
                self.detectedPoints = points
            }
        }
        return cameraPreview
    }

    func updateUIView(_ uiView: CameraPreview, context: Context) {}
}
