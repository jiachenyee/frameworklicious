//
//  CameraPreview.swift
//  Demo Project
//
//  Created by Jia Chen Yee on 12/06/23.
//

import Foundation
import Vision
import AVFoundation
import UIKit

final class CameraPreview: UIView {
    private let captureSession = AVCaptureSession()
    private let videoOutput = AVCaptureVideoDataOutput()
    var detectedPointsCallback: (([VNRecognizedPointKey: CGPoint]) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCaptureSession()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCaptureSession()
    }

    var size: CGSize!
    
    private func setupCaptureSession() {
        captureSession.beginConfiguration()

        guard let captureDevice = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInTrueDepthCamera, for: .video, position: .front),
              let captureDeviceInput = try? AVCaptureDeviceInput(device: captureDevice),
              captureSession.canAddInput(captureDeviceInput) else { fatalError() }
        
        size = CGSize(width: CGFloat(captureDevice.activeFormat.supportedMaxPhotoDimensions.first!.width),
                      height: CGFloat(captureDevice.activeFormat.supportedMaxPhotoDimensions.first!.height))

        captureSession.addInput(captureDeviceInput)

        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(videoOutput)

        captureSession.commitConfiguration()
        
        DispatchQueue.global(qos: .utility).async {
            self.captureSession.startRunning()
        }

        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(previewLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if let previewLayer = layer.sublayers?.first as? AVCaptureVideoPreviewLayer {
            previewLayer.frame = bounds
        }
    }
}

extension CameraPreview: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let requestOptions: [VNImageOption: Any] = [:]
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .leftMirrored, options: requestOptions)

        let poseRequest = VNDetectHumanBodyPoseRequest { request, error in
            guard let observations = request.results as? [VNRecognizedPointsObservation] else { return }
            let recognizedPoints = observations.flatMap { observation in
                observation.availableKeys.map { try? observation.recognizedPoint(forKey: $0) }
            }.compactMap { $0 }
            
            guard recognizedPoints.count > 0 else { return }
            
            DispatchQueue.main.async {
                print(recognizedPoints)
                
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
