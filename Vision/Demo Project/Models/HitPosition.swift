//
//  HitPosition.swift
//  Demo Project
//
//  Created by Jia Chen Yee on 14/06/23.
//

import Foundation

enum HitPosition: String, CaseIterable {
    case _0x0 = "0x0"
    case _1x0 = "1x0"
    case _2x0 = "2x0"
    case _0x1 = "0x1"
    case _1x1 = "1x1"
    case _2x1 = "2x1"
    case _0x2 = "0x2"
    case _1x2 = "1x2"
    case _2x2 = "2x2"
    case _0x3 = "0x3"
    case _1x3 = "1x3"
    case _2x3 = "2x3"
    case _0x4 = "0x4"
    case _1x4 = "1x4"
    case _2x4 = "2x4"
    
    init?(x: Int, y: Int) {
        self.init(rawValue: "\(x)x\(y)")
    }
    
    var x: Int {
        Int(self.rawValue.split(separator: "x")[0])!
    }
    
    var y: Int {
        Int(self.rawValue.split(separator: "x")[1])!
    }
}
