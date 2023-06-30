//
//  AnimationConfiguration+Extension.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 23/06/23.
//

import Foundation

extension AnimationConfiguration {
    var durationVal: Double {
        if let n = NumberFormatter().number(from: duration) {
            return Double(truncating: n)
        }
        
        return Double(0)
    }
    
    var responseVal: Double {
        if let n = NumberFormatter().number(from: response) {
            return Double(truncating: n)
        }
        
        return Double(0)
    }
    
    var dampingFractionVal: Double {
        if let n = NumberFormatter().number(from: dampingFraction) {
            return Double(truncating: n)
        }
        
        return Double(0)
    }
    
    var delayVal: Double {
        if let n = NumberFormatter().number(from: delay) {
            return Double(truncating: n)
        }
        
        return Double(0)
    }
    
    var speedVal: Double {
        if let n = NumberFormatter().number(from: speed) {
            return Double(truncating: n)
        }
        
        return Double(0)
    }
    
    var repeatCountVal: Int {
        if let n = NumberFormatter().number(from: repeatCount) {
            return Int(truncating: n)
        }
        
        return Int(1)
    }
    
    var repeatModeVal: Repeat {
       return repeatMode
    }
}
