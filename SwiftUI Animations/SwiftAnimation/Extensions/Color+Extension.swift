//
//  Color+Extension.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 24/06/23.
//

import SwiftUI

extension ShapeStyle where Self == Color {
    static func getFillColor(fillColor:FillColor) -> Color {
        switch fillColor {
        case .black:
            return Color.black
        case .white:
            return Color.white
        case .green:
            return Color.green
        case .blue:
            return Color.blue
        case .brown:
            return Color.brown
        case .clear:
            return Color.clear
        case .cyan:
            return Color.cyan
        case .gray:
            return Color.gray
        case .indigo:
            return Color.indigo
        case .mint:
            return Color.mint
        case .orange:
            return Color.orange
        case .pink:
            return Color.pink
        case .purple:
            return Color.purple
        case .red:
            return Color.red
        case .teal:
            return Color.teal
        case .yellow:
            return Color.yellow
        }
    }
}
