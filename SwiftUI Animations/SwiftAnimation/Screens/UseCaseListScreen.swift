//
//  UseCaseListScreen.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 28/06/23.
//

import SwiftUI

struct UseCaseListScreen: View {
    @EnvironmentObject private var useCaseNavigation: UseCaseNavigationManager
    @EnvironmentObject var colorTheme: ColorTheme
    
    var body: some View {
        VStack {
            C4Toolbar(title: "Use Case")
            
            
            ScrollView {
                VStack(spacing: 12) {
                    C4UseCaseItem(label: "Chart Animation 1") {
                        useCaseNavigation.push(to: .useCaseOne)
                    }
                    
                    C4UseCaseItem(label: "Chart Animation 2") {
                        useCaseNavigation.push(to: .useCaseTwo)
                    }
                    
                    C4UseCaseItem(label: "View Transition") {
                        useCaseNavigation.push(to: .useCaseThree)
                    }
                    C4UseCaseItem(label: "Use Case of Animations") {
                        useCaseNavigation.push(to: .useCaseFour)
                    }
                    
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }
            
            Spacer()
        }
        .onAppear {
            colorTheme.setToLight()
        }
    }
}

struct UseCaseListScreen_Previews: PreviewProvider {
    static var previews: some View {
        UseCaseListScreen()
    }
}
