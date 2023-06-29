//
//  CircleView.swift
//  Demo Project
//
//  Created by Dini on 27/06/23.
//

import Foundation
import SwiftUI

struct CircleView: View {

    private let shadowOffset: CGFloat = 8
    private let shadowRadius: CGFloat = 3
    private let shadowColor: Color = .foregroundGray
    private let highlightColor: Color = .white

    var body: some View {
        Circle().fill(Color.backgroundGray)
            .shadow(color: shadowColor, radius: shadowRadius, x: shadowOffset, y: shadowOffset)
            .shadow(color: highlightColor, radius: shadowRadius, x: -shadowOffset, y: -shadowOffset)
    }
}
