//
//  SpriteKit_DemoApp.swift
//  SpriteKit-Demo
//
//  Created by Jia Chen Yee on 09/06/23.
//

import SwiftUI
import FrameworkliciousCore

@main
struct SpriteKit_DemoApp: App {
    var body: some Scene {
        WindowGroup {
            FrameworkliciousApp(framework: .vision) {
                ContentView()
            }
        }
    }
}
