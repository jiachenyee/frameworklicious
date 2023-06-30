//
//  Animation+Extension.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 23/06/23.
//

import SwiftUI

enum TimeAlgo: String, CaseIterable {
    case linear, easeIn, easeOut, easeInOut, spring
}

enum Repeat {
    case forever, count, none
}

struct GeneralConfiguration: AnimationConfiguration {
    var duration: String
    
    var response: String
    
    var dampingFraction: String
      
    var speed: String
    
    var delay: String
    
    var repeatCount: String
    
    var repeatMode: Repeat
}

extension Animation {
    
    static let openCard = Animation.spring(response: 0.6, dampingFraction: 0.8)
    static let closeCard = Animation.spring(response: 0.6, dampingFraction: 0.9)
    
    static func getAnimation(timeAlgo: TimeAlgo, configuration: GeneralConfiguration) -> Animation {
        if configuration.repeatModeVal == .forever {
            switch timeAlgo {
            case .linear:
                return Animation
                    .linear(duration: configuration.durationVal)
                    .delay(configuration.delayVal)
                    .speed(configuration.speedVal)
                    .repeatForever()
                
            case .easeIn:
                return Animation
                    .easeIn(duration: configuration.durationVal)
                    .delay(configuration.delayVal)
                    .speed(configuration.speedVal)
                    .repeatForever()
                
            case .easeOut:
                return Animation
                    .easeOut(duration: configuration.durationVal)
                    .delay(configuration.delayVal)
                    .speed(configuration.speedVal)
                    .repeatForever()
                
            case .easeInOut:
                return Animation
                    .easeInOut(duration: configuration.durationVal)
                    .delay(configuration.delayVal)
                    .speed(configuration.speedVal)
                    .repeatForever()
                
            case .spring:
                return Animation
                    .spring(response: configuration.responseVal, dampingFraction: configuration.dampingFractionVal)
                    .delay(configuration.delayVal)
                    .speed(configuration.speedVal)
                    .repeatForever()
            }
        }
        
        else if configuration.repeatModeVal == .count  {
            switch timeAlgo {
            case .linear:
                return Animation
                    .linear(duration: configuration.durationVal)
                    .delay(configuration.delayVal)
                    .speed(configuration.speedVal)
                    .repeatCount(configuration.repeatCountVal)
                
            case .easeIn:
                return Animation
                    .easeIn(duration: configuration.durationVal)
                    .delay(configuration.delayVal)
                    .speed(configuration.speedVal)
                    .repeatCount(configuration.repeatCountVal)
                
            case .easeOut:
                return Animation
                    .easeOut(duration: configuration.durationVal)
                    .delay(configuration.delayVal)
                    .speed(configuration.speedVal)
                    .repeatCount(configuration.repeatCountVal)
                
            case .easeInOut:
                return Animation
                    .easeInOut(duration: configuration.durationVal)
                    .delay(configuration.delayVal)
                    .speed(configuration.speedVal)
                    .repeatCount(configuration.repeatCountVal)
                
            case .spring:
                return Animation
                    .spring(response: configuration.responseVal, dampingFraction: configuration.dampingFractionVal)
                    .delay(configuration.delayVal)
                    .speed(configuration.speedVal)
                    .repeatCount(configuration.repeatCountVal)
            }
        }
        
        else {
            switch timeAlgo {
            case .linear:
                return Animation
                    .linear(duration: configuration.durationVal)
                    .delay(configuration.delayVal)
                    .speed(configuration.speedVal)
                
            case .easeIn:
                return Animation
                    .easeIn(duration: configuration.durationVal)
                    .delay(configuration.delayVal)
                    .speed(configuration.speedVal)
                
            case .easeOut:
                return Animation
                    .easeOut(duration: configuration.durationVal)
                    .delay(configuration.delayVal)
                    .speed(configuration.speedVal)
                
            case .easeInOut:
                return Animation
                    .easeInOut(duration: configuration.durationVal)
                    .delay(configuration.delayVal)
                    .speed(configuration.speedVal)
                
            case .spring:
                return Animation
                    .spring(response: configuration.responseVal, dampingFraction: configuration.dampingFractionVal)
                    .delay(configuration.delayVal)
                    .speed(configuration.speedVal)
            }
        }
    }
}
