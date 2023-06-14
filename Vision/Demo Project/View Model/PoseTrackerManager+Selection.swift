//
//  PoseTrackerManager+Selection.swift
//  Demo Project
//
//  Created by Jia Chen Yee on 14/06/23.
//

import Foundation
import Vision

extension PoseTrackerManager {
    /// Check if the user's current hand positions select the target position
    func checkSelection() {
        let selectedSections = getSelectedSections()
        
        if didHitTarget(selectedSections: selectedSections) {
            handlePointHit(selectedSections)
        }
        
        self.selectedSections = selectedSections
    }
    
    /// Retrieve selected sections based on the current user's hand positions
    /// - Returns: A collection of labelled points which indicate the position and hand.
    fileprivate func getSelectedSections() -> [HandPosition] {
        guard let viewSize else { return [] }
        
        var positions: [HandPosition] = []
        
        if let leftPosition = getPosition(for: .left, withSize: viewSize) {
            positions.append((.left, leftPosition))
        }
        
        if let rightPosition = getPosition(for: .right, withSize: viewSize) {
            positions.append((.right, rightPosition))
        }

        return positions
    }
    
    /// Check if any of the input positions hit the target
    /// - Parameter positions: An array of labelled points in the form of ``HandPosition``s.
    /// - Returns: A Boolean value, indicating if any of the hands hit the intended target
    fileprivate func didHitTarget(selectedSections positions: [HandPosition]) -> Bool {
        
        // Get the current position of the target hand
        guard let targetHandCurrentPosition = positions.first(where: {
            $0.hand == targetHand
        }) else { return false }
        
        // Return whether or not the target hand's current
        //   position is the same as the target position.
        // If so, this indicates that the target hand is
        //   selecting the right location
        return targetHandCurrentPosition.position == targetPosition
    }
    
    /// Handle when the target point is successfully selected by the user
    ///
    /// This method will generate the next position the user should select as
    /// well as the hand the user should select it with.
    ///
    /// An array of selected positions (positions where the hands are at), is
    /// passed in to ensure that the new positions are not one where the user's
    /// hands are currently at.
    ///
    /// - Parameter positions: An array of selected positions.
    fileprivate func handlePointHit(_ positions: [HandPosition]) {
        var potentialPositions = HitPosition.allCases
        potentialPositions.removeAll { position in
            positions.contains { (_, hitPosition) in
                hitPosition == position
            }
        }
        
        targetPosition = potentialPositions.randomElement()!
        targetHand = .random
    }
    
    /// Get the position of a specific hand from the raw vision data
    /// - Parameters:
    ///   - hand: Hand to get the position of from the raw vision data
    ///   - viewSize: View port's size to calculate the hit position
    /// - Returns: The hit position of the selected hand
    fileprivate func getPosition(for hand: Hand, withSize viewSize: CGSize) -> HitPosition? {
        
        if let leftWrist = detectedPoints[hand.visionKey] {
            let x = floor(leftWrist.x / (viewSize.width / 3))
            let y = floor(leftWrist.y / (viewSize.height / 5))
            
            if let position = HitPosition(x: Int(x), y: Int(y)) {
                return position
            }
        }
        
        return nil
    }
}
