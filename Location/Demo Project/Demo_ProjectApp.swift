//
//  Demo_ProjectApp.swift
//  Demo Project
//
//  Created by Jia Chen Yee on 12/06/23.
//

import SwiftUI
import FrameworkliciousCore

@main
struct Demo_ProjectApp: App {
    var body: some Scene {
        WindowGroup {
            FrameworkliciousApp(framework: .coreLocation) {
                ContentView(framework: .coreLocation)
            }
        }
    }
}
