//
//  CGPoint.swift
//  Demo Project
//
//  Created by Jia Chen Yee on 14/06/23.
//

import Foundation

extension CGPoint {
    func distance(to otherPoint: CGPoint) -> CGFloat {
        sqrt(pow(x - otherPoint.x, 2) + pow(y - otherPoint.y, 2))
    }
}
