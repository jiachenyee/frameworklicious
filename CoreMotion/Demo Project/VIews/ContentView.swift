//
//  ContentView.swift
//  Demo Project
//
//  Created by Jia Chen Yee on 12/06/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var coreMotionManager = CoreMotionManager()
    
    var body: some View {
        VStack {
            if let accelerometerData = coreMotionManager.accelerometerData {
                Text("Accelerometer Data: x: \(accelerometerData.acceleration.x), y: \(accelerometerData.acceleration.y), z: \(accelerometerData.acceleration.z)")
            }
            
            if let gyroData = coreMotionManager.gyroData {
                Text("Gyro Data: x: \(gyroData.rotationRate.x), y: \(gyroData.rotationRate.y), z: \(gyroData.rotationRate.z)")
            }
            
            if let magnetometerData = coreMotionManager.magnetometerData {
                Text("Magnetometer Data: x: \(magnetometerData.magneticField.x), y: \(magnetometerData.magneticField.y), z: \(magnetometerData.magneticField.z)")
            }
            
            if let pedometerData = coreMotionManager.pedometerData {
                Text("Pedometer Data: Steps: \(pedometerData.numberOfSteps)")
            }
        }.onDisappear {
            coreMotionManager.stopMotionUpdates()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

