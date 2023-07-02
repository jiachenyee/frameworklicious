//
//  MainView.swift
//  Demo Project
//
//  Created by Muhammad Irfan on 02/07/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                NavigationLink("Motion Data", destination: ContentView())
                NavigationLink("Fall Detection", destination: FallDetectionView())
                NavigationLink("Pressure Data", destination: PressureView())
                NavigationLink("Activity Music Controller", destination: ActivityMusicView())
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
