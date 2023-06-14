//
//  PoseTrackerManager+Clapping.swift
//  Demo Project
//
//  Created by Jia Chen Yee on 14/06/23.
//

import Foundation
import Vision

extension PoseTrackerManager {
    func isClapping() {
        let index = previousClapPoints.count - 14
        
        guard let (currentLeftWrist, currentRightWrist) = getHandPositions(from: detectedPoints),
              index > 0 else { return }
        
        let previousTargetPoint = previousClapPoints[index].1
        
        guard abs(previousClapPoints[index].0.timeIntervalSinceNow) < 1,
              let (previousLeftWrist, previousRightWrist) = getHandPositions(from: previousTargetPoint) else { return }
        
        let currentWristDistance = currentLeftWrist.distance(to: currentRightWrist)
        let previousWristDistance = previousLeftWrist.distance(to: previousRightWrist)
        
        if previousWristDistance > currentWristDistance && previousWristDistance / currentWristDistance > 2 {
            handlePotentialClap()
        }
    }
    
    fileprivate func getHandPositions(from points: [VNRecognizedPointKey: CGPoint]) -> (CGPoint, CGPoint)? {
        guard let currentLeftWrist = points[Hand.left.visionKey],
              let currentRightWrist = points[Hand.right.visionKey] else { return nil }
        
        return (currentLeftWrist, currentRightWrist)
    }
    
    fileprivate func handlePotentialClap() {
        if abs((lastClappingDetected ?? .distantPast).timeIntervalSinceNow) > 0.2 && userState == .waitingToStart {
            userState = .started
        }
        
        lastClappingDetected = .now
    }
}
