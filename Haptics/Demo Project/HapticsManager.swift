//
//  HapticsManager.swift
//  Demo Project
//
//  Created by Gerson Janhuel on 26/06/23.
//

import Foundation
import CoreHaptics

enum HapticSample: String {
    case sparkle = "Sparkle"
    case heartbeats = "Heartbeats"
    case boing = "Boing"
    case inflate = "Inflate"
    case gravel = "Gravel"
    case rumble = "Rumble"
    case oscillate = "Oscillate"
    case drums = "Drums"
    case lamborghini = "Lamborghini"
}

class HapticsManager: ObservableObject {
    @Published var engine: CHHapticEngine?
    
    
    // check device compatibility
    lazy var supportHaptics: Bool = {
        return CHHapticEngine.capabilitiesForHardware().supportsHaptics
    }()
    
    // prepare haptic engine
    func prepareHaptics() {
        guard supportHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func playHapticSample(_ haptic: HapticSample) {
        print("play \(haptic)")
        
        switch haptic {
        case .boing:
            playHapticsPatternProgrammatically()
        default:
            playHapticsFile(named: "AHAP/\(haptic.rawValue)")
        }
    }
    
    // Play haptics pattern from AHAP file
    private func playHapticsFile(named filename: String) {
        
        // If the device doesn't support Core Haptics, abort.
        guard supportHaptics else { return }
        
        // Express the path to the AHAP file before attempting to load it.
        guard let path = Bundle.main.path(forResource: filename, ofType: "ahap") else {
            return
        }
        
        do {
            // Start the engine in case it's idle.
            try engine?.start()
            
            // Tell the engine to play a pattern.
            try engine?.playPattern(from: URL(fileURLWithPath: path))
            
        } catch { // Engine startup errors
            print("An error occured playing \(filename): \(error).")
        }
    }
    
    // Play the Boing effect haptic pattern programmatically
    // You can see the AHAP format in AHAP/Boing.ahap, compare the code and the JSON based format.
    private func playHapticsPatternProgrammatically() {
        // check if the device do support Core Haptics
        guard supportHaptics else { return }
        
        // create events and its parameters
        let event1 = CHHapticEvent(eventType: .hapticTransient, parameters: [
            CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8),
            CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.4)], relativeTime: 0.0)
        
        let event2 = CHHapticEvent(eventType: .hapticContinuous,parameters: [
            CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8),
            CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.4)], relativeTime: 0.015, duration: 0.25)
        
        
        // optional: create parameter curves
        let curve1 = CHHapticParameterCurve(parameterID: .hapticIntensityControl, controlPoints: [CHHapticParameterCurve.ControlPoint(relativeTime: 0, value: 1), CHHapticParameterCurve.ControlPoint(relativeTime: 0.1, value: 0.5), CHHapticParameterCurve.ControlPoint(relativeTime: 0.25, value: 0.0)], relativeTime: 0.015)
        
        let curve2 = CHHapticParameterCurve(parameterID: .hapticSharpnessControl, controlPoints: [CHHapticParameterCurve.ControlPoint(relativeTime: 0, value: 0.0), CHHapticParameterCurve.ControlPoint(relativeTime: 0.25, value: -0.3)], relativeTime: 0.015)
        
        // create pattern, add events into pattern, then play
        do {
            let pattern = try CHHapticPattern(events: [event1, event2], parameterCurves: [curve1, curve2])
            
            let player = try engine?.makePlayer(with: pattern)
            
            try player?.start(atTime: CHHapticTimeImmediate)
            
        } catch {
            print("Failed to play pattern \(error.localizedDescription)")
        }
    }
    
}
