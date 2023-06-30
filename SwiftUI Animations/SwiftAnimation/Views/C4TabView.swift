//
//  C4TabView.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 27/06/23.
//

import SwiftUI

enum NavigationTabs: String {
    case playground = "Playground"
    case useCase = "UseCase"
}

struct C4TabView: View {
    @StateObject var colorTheme = ColorTheme()
    
    @Binding var selectedTab: NavigationTabs
    
    @ObservedObject var useCaseNavigation: UseCaseNavigationManager
    
    var body: some View {
        TabView(selection: $selectedTab) {
            AnimationPlaygroundScreen()
            .tabItem {
                Label {
                    Text("Playground")
                } icon: {
                    Image(systemName: "rectangle.3.group.fill")
                }
            }
            .tag(NavigationTabs.playground)
            
            NavigationStack(path: $useCaseNavigation.paths) {
                UseCaseListScreen()
                    .navigationDestination(for: UseCaseRoute.self) { route in
                        switch(route) {
                        case .useCaseOne:
                            ChartAnimateView()
                        case .useCaseTwo:
                            ChartCustomAnimateView()
                        case .useCaseThree:
                            HomeView()
                                .environmentObject(Model())
                        case .useCaseFour:
                            ListOfAnimationView()
                        }
                    }
            }
            .tabItem {
                Label {
                    Text("Use Cases")
                } icon: {
                    Image(systemName: "text.book.closed.fill")
                }
            }
            .tag(NavigationTabs.useCase)
            
            .environmentObject(useCaseNavigation)
        }
        .preferredColorScheme(colorTheme.isDarkMode ? .dark : .light)
        .environmentObject(colorTheme)
    }
}
