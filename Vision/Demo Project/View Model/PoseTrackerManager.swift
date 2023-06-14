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
    
    typealias HandPosition = (hand: Hand, position: HitPosition)
    
    var previousClapPoints: [(Date, [VNRecognizedPointKey: CGPoint])] = []
    
    var lastClappingDetected: Date?
    
    var viewSize: CGSize?
    
    @Published var targetHand: Hand = .left
    @Published var targetPosition: HitPosition = HitPosition.allCases.randomElement()!
    
    @Published var selectedSections: [HandPosition] = []
    
    @Published var userState = UserState.waitingToStart
    
    @Published var detectedPoints: [VNRecognizedPointKey: CGPoint] = [:] {
        didSet {
            onDetectionUpdate()
        }
    }
    
    func onDetectionUpdate() {
        isClapping()
        checkSelection()
        
        if detectedPoints.contains(where: { (key, _) in
            key == Hand.left.visionKey
        }) && detectedPoints.contains(where: { (key, _) in
            key == Hand.right.visionKey
        }) {
            previousClapPoints.append((.now, detectedPoints))
        }
    }
}
