//
//  PositionedRectangle.swift
//  Demo Project
//
//  Created by Jia Chen Yee on 15/06/23.
//

import SwiftUI

struct PositionedRectangle: View {
    
    var targetPosition: HitPosition
    
    var color: Color
    
    var geometry: GeometryProxy
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: geometry.size.width / 3,
                   height: geometry.size.height / 5)
            .offset(x: CGFloat(targetPosition.x) * geometry.size.width / 3,
                    y: CGFloat(targetPosition.y) * geometry.size.height / 5)
    }
}
