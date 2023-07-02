//
//  ControllerViewModel.swift
//  Air Hockey Controller
//
//  Created by Muhammad Irfan on 30/06/23.
//

import CoreMotion
import SwiftUI
import MultipeerConnectivity

class ControllerViewModel: ObservableObject {
    weak var parentViewModel: StartControllerViewModel?
    
    @Published var multipeerHandler: ControllerMultipeerHandler
    
    // for coreMotion
    let motionManager = CMMotionManager()
    @Published var accelerometerData: CMAccelerometerData?
    @Published var movX: Int = 0
    @Published var movY: Int = 0
    
    init(multipeerHandler: ControllerMultipeerHandler, parentViewModel: StartControllerViewModel?) {
        self.multipeerHandler = multipeerHandler
        self.accelerometerData = nil
        self.movX = 0
        self.movY = 0
        self.parentViewModel = parentViewModel
        self.multipeerHandler.delegate = self
    }
    
    func startAccelerometerUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: OperationQueue.main) { [weak self] data, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Failed to update accelerometer: \(error)")
                    return
                }
                
                guard let accelerometerData = data else {
                    print("No accelerometer data available")
                    return
                }
                
                self.accelerometerData = accelerometerData
                self.movX = Int(accelerometerData.acceleration.x * 100)
                self.movY = Int(accelerometerData.acceleration.y * 100)
                
                print("acceleration x: \(accelerometerData.acceleration.x), z: \(accelerometerData.acceleration.y), z: \(accelerometerData.acceleration.z)")
                
                let position = Position(x: self.movX, y: self.movY)
                
                // Send the data
                self.multipeerHandler.sendPositionData(position: position)
            }
        }
    }
    
    func startDeviceMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1 
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { [weak self] (deviceMotion, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("Failed to update device motion: \(error)")
                    return
                }
                
                guard let deviceMotion = deviceMotion else {
                    print("No device motion data available")
                    return
                }
                
                let gravity = deviceMotion.gravity
                let userAcceleration = deviceMotion.userAcceleration

                let gravityAdjustedX = userAcceleration.x - gravity.x
                let gravityAdjustedY = userAcceleration.y - gravity.y
                
                self.movX = Int(gravityAdjustedX * 100)
                self.movY = Int(gravityAdjustedY * 100)

                let position = Position(x: self.movX, y: self.movY)
                
                // Send the data
                self.multipeerHandler.sendPositionData(position: position)
            }
        }
    }
    
    func resetPosition(){
        multipeerHandler.sendResetPosition()
    }
    
    func endGame(){
        stopAccelerometerUpdates()
        parentViewModel?.cancelGame()
    }
    
    func stopAccelerometerUpdates() {
        motionManager.stopAccelerometerUpdates()
    }
    
    func stopDeviceMotionnUpdates() {
        motionManager.stopDeviceMotionUpdates()
    }
}

extension ControllerViewModel: ControllerMultipeerHandlerDelegate {
    func disconnected(peerID: MCPeerID) {
        endGame()
    }
    
    func didReceive(data: Data, from peerID: MCPeerID) {
        
    }
    
    func connected(peerID: MCPeerID) {
      
    }
}
