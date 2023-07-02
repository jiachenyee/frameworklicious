//
//  FallDetectionVIew.swift
//  Demo Project
//
//  Created by Muhammad Irfan on 02/07/23.
//

import SwiftUI

struct FallDetectionView: View {
    
    @StateObject private var coreMotionManager = CoreMotionManager()
    
    var body: some View {
        VStack {
            Text(coreMotionManager.isFallDetected ? "Fall Detected" : "No Fall Detected")
                .onReceive(coreMotionManager.$accelerometerData, perform: { data in
                    if let data = data {
                        coreMotionManager.detectFall(with: data.acceleration)
                    }
                })
        }
    }
}

struct FallDetectionVIew_Previews: PreviewProvider {
    static var previews: some View {
        FallDetectionView()
    }
}
