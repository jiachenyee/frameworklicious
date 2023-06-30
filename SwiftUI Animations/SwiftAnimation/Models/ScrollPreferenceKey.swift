//
//  ScrollPreferenceKey.swift
//  SwiftAnimation
//
//  Created by Wahyu Alfandi on 29/06/23.
//


import SwiftUI

struct ScrollPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue:() -> CGFloat) {
        value = nextValue()
    }
}
