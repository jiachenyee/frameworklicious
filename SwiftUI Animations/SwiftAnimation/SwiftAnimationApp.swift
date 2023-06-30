//
//  SwiftAnimationApp.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 16/06/23.
//

import SwiftUI

@main
struct SwiftAnimationApp: App {
    @StateObject var useCaseNavigation = UseCaseNavigationManager()
    
    @State private var selectedTab: NavigationTabs = .playground
    @StateObject var model = Model()
    
    var body: some Scene {
        WindowGroup {
            C4TabView(selectedTab: $selectedTab, useCaseNavigation: useCaseNavigation)
        }
    }
}
