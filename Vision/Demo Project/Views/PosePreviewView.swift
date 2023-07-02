//
//  PosePreviewView.swift
//  Demo Project
//
//  Created by Jia Chen Yee on 15/06/23.
//

import SwiftUI
import Vision

struct PosePreviewView: View {
    
    var detectedPoints: [VNRecognizedPointKey: CGPoint]
    
    let armsLineKeys: [VNHumanBodyPoseObservation.JointName] = [
        .leftWrist,
        .leftElbow,
        .leftShoulder,
        .neck,
        .rightShoulder,
        .rightElbow,
        .rightWrist
    ]
    
    let bodyLineKeys: [VNHumanBodyPoseObservation.JointName] = [
        .neck,
        .root,
        .leftHip,
        .leftKnee,
        .leftAnkle,
        .leftKnee,
        .leftHip,
        .root,
        .rightHip,
        .rightKnee,
        .rightAnkle,
    ]
    
    var body: some View {
        ZStack {
            ForEach(detectedPoints.map({
                (key: $0, value: $1)
            }), id: \.key) { point in
                ZStack {
                    Circle()
                        .fill(Hand(point.key)?.color ?? .white)
                }
                .frame(width: 20, height: 20)
                .position(point.value)
            }
            
            Path { path in
                var needsMove = true
                
                for key in armsLineKeys {
                    if let point = detectedPoints[key.rawValue] {
                        if needsMove {
                            path.move(to: point)
                            
                            needsMove = false
                        } else {
                            path.addLine(to: point)
                        }
                    }
                }
            }
            .stroke(.white, lineWidth: 5)
            
            Path { path in
                var needsMove = true
                
                for key in bodyLineKeys {
                    if let point = detectedPoints[key.rawValue] {
                        if needsMove {
                            path.move(to: point)
                            
                            needsMove = false
                        } else {
                            path.addLine(to: point)
                        }
                    }
                }
            }
            .stroke(.white, lineWidth: 5)
            
            if let leftEar = detectedPoints[VNHumanBodyPoseObservation.JointName.leftEar.rawValue],
               let rightEar = detectedPoints[VNHumanBodyPoseObservation.JointName.rightEar.rawValue],
               let neck = detectedPoints[VNHumanBodyPoseObservation.JointName.neck.rawValue],
               let nose = detectedPoints[VNHumanBodyPoseObservation.JointName.nose.rawValue] {
                
                let ellipseWidth = abs(leftEar.x - rightEar.x)
                let ellipseHeight = abs(nose.y - neck.y)
                
                Ellipse()
                    .stroke(.white, lineWidth: 5)
                    .frame(width: ellipseWidth, height: ellipseHeight)
                    .position(nose)
            }
        }
    }
}
