//
//  PoseTrackerManager.swift
//  Demo Project
//
//  Created by Jia Chen Yee on 14/06/23.
//

import Foundation
import SwiftUI
import Vision

class PoseTrackerManager: ObservableObject {
    
    // MARK: - Prediction Data
    /// Attach a hand to a position value to create tagged positions.
    typealias HandPosition = (hand: Hand, position: HitPosition)
    
    /// Store all previous points.
    ///
    /// This will be used to determine and detect when a hand is clapping.
    var previousPoints: [(Date, [VNRecognizedPointKey: CGPoint])] = []
    
    /// Storing the last time a clap was detected.
    ///
    /// This is used to determine clapping.
    var lastClappingDetected: Date?
    
    /// Get the view's size.
    ///
    /// This is used to determine the user's hover location.
    var viewSize: CGSize?
    
    /// An array of the latest detected points.
    ///
    /// This is directly passed in from the Vision view
    @Published var detectedPoints: [VNRecognizedPointKey: CGPoint] = [:] {
        didSet {
            onDetectionUpdate()
        }
    }
    
    // MARK: - Game Information
    /// The hand the user should use to hit the box.
    @Published var targetHand: Hand = .left
    
    /// The position of the box the user has to hit.
    @Published var targetPosition: HitPosition = HitPosition.allCases.randomElement()!
    
    /// The sections on-screen that are selected
    @Published var selectedSections: [HandPosition] = []
    
    // MARK: - Game State
    
    /// The game's current state
    @Published var userState = UserState.waitingToStart
    
    @Published var gameSeconds = 0
    @Published var gameScore = 0
    @Published var randomPhoto: UIImage?
    
    fileprivate func updatePreviousPoints() {
        if detectedPoints.contains(where: { (key, _) in
            key == Hand.left.visionKey
        }) && detectedPoints.contains(where: { (key, _) in
            key == Hand.right.visionKey
        }) {
            previousPoints.append((.now, detectedPoints))
        }
    }
    
    func setRandomPhoto(_ image: UIImage) {
        if userState == .started {
            randomPhoto = image
        }
    }
    
    func onDetectionUpdate() {
        
        switch userState {
        case .waitingToStart:
            isUserClapping()
        case .started:
            checkSelection()
        case .gameOver:
            break
        }
        
        updatePreviousPoints()
    }
}
