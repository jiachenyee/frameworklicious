//
//  CameraPreview+AVCaptureVideoDataOutputSampleBufferDelegate.swift
//  Demo Project
//
//  Created by Jia Chen Yee on 15/06/23.
//

import Foundation
import AVFoundation
import Vision

extension CameraPreview: AVCaptureVideoDataOutputSampleBufferDelegate {
    // Receives input on every frame
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let requestOptions: [VNImageOption: Any] = [:]
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .leftMirrored, options: requestOptions)

        // Run Vision Body Detection
        let poseRequest = VNDetectHumanBodyPoseRequest { request, error in
            guard let observations = request.results as? [VNRecognizedPointsObservation] else { return }
            let recognizedPoints = observations.flatMap { observation in
                observation.availableKeys.map { try? observation.recognizedPoint(forKey: $0) }
            }.compactMap { $0 }
            
            guard recognizedPoints.count > 0 else { return }
            
            DispatchQueue.main.async {
                var points: [VNRecognizedPointKey: CGPoint] = [:]
                
                for point in recognizedPoints {
                    let convertedX = CGFloat(point.location.x) * self.bounds.width
                    let convertedY = CGFloat(1 - point.location.y) * self.bounds.height
                    
                    if CGPoint(x: convertedX, y: convertedY) != .zero {
                        points[point.identifier] = CGPoint(x: convertedX, y: convertedY)
                    }
                }
                
                self.detectedPointsCallback?(points)
            }
        }

        do {
            try imageRequestHandler.perform([poseRequest])
        } catch {
            print("Error performing pose detection: \(error)")
        }
    }
}
