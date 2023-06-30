//
//  DarkMode.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 29/06/23.
//

import SwiftUI

@MainActor
class ColorTheme:ObservableObject {
    @Published var isDarkMode = false
    
    func setToLight() {
        self.isDarkMode = false
    }
    
    func setToDark() {
        self.isDarkMode = true
    }
}
