//
//  AnimatedShape+Extension.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 22/06/23.
//

import Foundation

extension AnimatedShape {
    var widthVal: CGFloat {
        if let n = NumberFormatter().number(from: width) {
            return CGFloat(truncating: n)
        }
        
        return CGFloat(0)
    }
    
    var heightVal:CGFloat {
        if let n = NumberFormatter().number(from: height) {
            return CGFloat(truncating: n)
        }
        
        return CGFloat(0)
    }
    
    var halfWidth: CGFloat {
        if let n = NumberFormatter().number(from: width) {
            return CGFloat(truncating: n) / 2
        }
        
        return CGFloat(0)
    }
    
    var halfHeight:CGFloat {
        if let n = NumberFormatter().number(from: height) {
            return CGFloat(truncating: n) / 2
        }
        
        return CGFloat(0)
    }
}
