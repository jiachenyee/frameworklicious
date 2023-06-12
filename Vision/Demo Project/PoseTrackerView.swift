//
//  PoseTrackerView.swift
//  Demo Project
//
//  Created by Jia Chen Yee on 12/06/23.
//

import Foundation
import SwiftUI
import Vision

struct PoseTrackerView: View {
    @State private var detectedPoints: [VNRecognizedPointKey: CGPoint] = [:]

    var body: some View {
        ZStack {
            CameraView(detectedPoints: $detectedPoints)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                .onChange(of: detectedPoints) { newValue in
                    print(newValue)
                }
            
            ForEach(detectedPoints.map({
                (key: $0, value: $1)
            }), id: \.key) { point in
                
                ZStack {
                    Circle()
                        .fill(.red)
                }
                .frame(width: 20, height: 20)
                .position(point.value)
            }
        }
    }
}

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
