//
//  ActivityMusicView.swift
//  Demo Project
//
//  Created by Muhammad Irfan on 02/07/23.
//

import SwiftUI

struct ActivityMusicView: View {
    @StateObject private var coreMotionManager = CoreMotionManager()
    
    var body: some View {
        VStack {
            Text("Activity Music Controller")
            Text("\(coreMotionManager.currentActivity)")
        }
        .onAppear {
            coreMotionManager.startMotionActivity()
        }
        .onDisappear {
            coreMotionManager.stopMotionUpdates()
        }
    }
}

struct ActivityMusicView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityMusicView()
    }
}
