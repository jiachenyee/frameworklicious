//
//  Hand.swift
//  Demo Project
//
//  Created by Jia Chen Yee on 14/06/23.
//

import Foundation
import SwiftUI
import Vision

enum Hand: Hashable, CaseIterable {
    case left
    case right
    
    var color: Color {
        switch self {
        case .left: return .blue
        case .right: return .red
        }
    }
    
    var visionKey: VNRecognizedPointKey {
        switch self {
        case .left:
            return VNHumanBodyPoseObservation.JointName.leftWrist.rawValue
        case .right:
            return VNHumanBodyPoseObservation.JointName.rightWrist.rawValue
        }
    }
    
    static var random: Hand {
        Self.allCases.randomElement()!
    }
    
    init?(_ visionKey: VNRecognizedPointKey) {
        switch visionKey {
        case VNHumanBodyPoseObservation.JointName.leftWrist.rawValue:
            self = .left
        case VNHumanBodyPoseObservation.JointName.rightWrist.rawValue:
            self = .right
        default: return nil
        }
    }
}
