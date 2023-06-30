//
//  AnimatedValue+Extension.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 22/06/23.
//

import SwiftUI

extension AnimatedValue where State == String {
    var beforeVal: CGFloat {
        if let n = NumberFormatter().number(from: before) {
            return CGFloat(truncating: n)
        }
        
        return CGFloat(0)
    }
    
    var afterVal:CGFloat {
        if let n = NumberFormatter().number(from: after) {
            return CGFloat(truncating: n)
        }
        
        return CGFloat(0)
    }
}

extension AnimatedValue where State == CGFloat {
    var beforeVal: CGFloat {
        before
    }
    
    var afterVal:CGFloat {
       after
    }
}

extension AnimatedValue where State == FillColor {
    var beforeVal: Color {
        Color.getFillColor(fillColor: before)
    }
    
    var afterVal: Color {
        Color.getFillColor(fillColor: after)
    }
}
