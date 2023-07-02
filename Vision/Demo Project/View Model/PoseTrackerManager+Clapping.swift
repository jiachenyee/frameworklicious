//
//  PoseTrackerManager+Clapping.swift
//  Demo Project
//
//  Created by Jia Chen Yee on 14/06/23.
//

import Foundation
import Vision

extension PoseTrackerManager {
    /// Check if a user is clapping
    func isUserClapping() {
        // Retrieve current body-tracking points
        let index = previousPoints.count - 14
        
        guard let (currentLeft, currentRight) = getHandPositions(from: detectedPoints),
              index > 0 else { return }
        
        // Retrieve previous body-tracking points
        let previousTargetPoint = previousPoints[index].1
        
        guard isTargetPointRecent(for: index),
              let (previousLeft, previousRight) = getHandPositions(from: previousTargetPoint) else { return }
        
        // Determine if user is clapping
        if checkIfClap(currentLeft: currentLeft,
                                          currentRight: currentRight,
                                          previousLeft: previousLeft,
                       previousRight: previousRight) {
            handlePotentialClap()
        }
    }
    
    /// Determine if the user is clapping using the current positions and the previous positions
    ///
    /// When the distance between the two hands is 0.5x that of 0.5 seconds ago,
    /// it counts it as a clap.
    fileprivate func checkIfClap(currentLeft: CGPoint, currentRight: CGPoint, previousLeft: CGPoint, previousRight: CGPoint) -> Bool {
        let currentDistance = currentLeft.distance(to: currentRight)
        let previousDistance = previousLeft.distance(to: previousRight)
        
        return previousDistance > currentDistance && previousDistance / currentDistance > 2
    }
    
    /// Determine if the target previous point is recent enough
    ///
    /// The app ignores values that are too old as it is considered too inaccurate.
    ///
    /// - Parameter index: Index within the `previousClapPoints` array
    /// - Returns: A Boolean, indicating whether the point is recent enough
    fileprivate func isTargetPointRecent(for index: Int) -> Bool {
        return abs(previousPoints[index].0.timeIntervalSinceNow) < 1
    }
    
    /// Get hand positions from the vision points
    /// - Parameter points: Raw vision points
    /// - Returns: A tuple of points representing the left and right hand position respectively
    fileprivate func getHandPositions(from points: [VNRecognizedPointKey: CGPoint]) -> (CGPoint, CGPoint)? {
        guard let currentLeftWrist = points[Hand.left.visionKey],
              let currentRightWrist = points[Hand.right.visionKey] else { return nil }
        
        return (currentLeftWrist, currentRightWrist)
    }
    
    /// Handle and validate when a potential clap is detected
    ///
    /// Validation is required to avoid repeats in the data. Instead of
    /// indicating that it was clapped 20-30 times per clap, this method
    /// ensures it only reports once per clap.
    fileprivate func handlePotentialClap() {
        if abs((lastClappingDetected ?? .distantPast).timeIntervalSinceNow) > 0.2 && userState == .waitingToStart {
            gameScore = 0
            gameSeconds = 0
            
            userState = .countdown
            
            Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { _ in
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] timer in
                    gameSeconds += 1
                    
                    if gameSeconds == 20 {
                        timer.invalidate()
                        userState = .gameOver
                    }
                }
            }
        }
        
        lastClappingDetected = .now
    }
}
