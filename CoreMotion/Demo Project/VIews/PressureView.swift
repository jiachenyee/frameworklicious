//
//  PressureView.swift
//  Demo Project
//
//  Created by Muhammad Irfan on 02/07/23.
//

import SwiftUI

struct PressureView: View {
    
    @StateObject private var coreMotionManager = CoreMotionManager()
    
    var body: some View {
        VStack {
            if let pressure = coreMotionManager.pressure {
                Text("Pressure: \(pressure) kPa")
            }
        }
    }
}

struct PressureView_Previews: PreviewProvider {
    static var previews: some View {
        PressureView()
    }
}
