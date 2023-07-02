//
//  CoreMotionManager.swift
//  Demo Project
//
//  Created by Muhammad Irfan on 02/07/23.
//

import Foundation
import CoreMotion
import AVFoundation

class CoreMotionManager: ObservableObject {
    
    private let motionManager = CMMotionManager()
    private let pedometer = CMPedometer()
    private let altimeter = CMAltimeter()
    private var lastAcceleration: CMAcceleration?
    private let activityManager = CMMotionActivityManager()
        private var audioPlayer: AVAudioPlayer?
    
    @Published var accelerometerData: CMAccelerometerData?
    @Published var gyroData: CMGyroData?
    @Published var magnetometerData: CMMagnetometerData?
    @Published var pedometerData: CMPedometerData?
    
    @Published var deviceMotion: CMDeviceMotion?
    @Published var isFallDetected = false
    @Published var pressure: NSNumber?
    
    
    @Published var currentActivity: String = "stationary"
    
    init() {
        startMotionUpdates()
    }
    
    private func startMotionUpdates() {
       
    }
    
    private func startAccelerometer() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.2
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
                self?.accelerometerData = data
            }
        }
    }
    
    private func startGyro() {
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.2
            motionManager.startGyroUpdates(to: .main) { [weak self] (data, error) in
                self?.gyroData = data
            }
        }
    }
    
    private func startMagnetometer() {
        if motionManager.isMagnetometerAvailable {
            motionManager.magnetometerUpdateInterval = 0.2
            motionManager.startMagnetometerUpdates(to: .main) { [weak self] (data, error) in
                self?.magnetometerData = data
            }
        }
    }
    
    private func startPedoMeter() {
        if CMPedometer.isStepCountingAvailable() {
            pedometer.startUpdates(from: Date()) { [weak self] (data, error) in
                self?.pedometerData = data
            }
        }
    }
    
    private func startMotion() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.2
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (data, error) in
                self?.deviceMotion = data
            }
        }
    }
    
    private func startAlitmeter() {
        if CMAltimeter.isRelativeAltitudeAvailable() {
            altimeter.startRelativeAltitudeUpdates(to: .main) { [weak self] (data, error) in
                self?.pressure = data?.pressure
            }
        }
    }
    
    func startMotionActivity () {
        if CMMotionActivityManager.isActivityAvailable() {
                    activityManager.startActivityUpdates(to: .main) { [weak self] (activity) in
                        self?.handleActivity(activity: activity)
                    }
                }
    }
    
    private func handleActivity(activity: CMMotionActivity?) {
            guard let activity = activity else { return }

            if activity.walking {
                playSound(named: "walkingSong.mp3")
                currentActivity = "walking"
            } else if activity.running {
                playSound(named: "runningSong.mp3")
                currentActivity = "running"
            } else if activity.stationary {
                audioPlayer?.stop()
                currentActivity = "stationary"
            }
        }
    
    private func playSound(named fileName: String) {
            if let soundURL = Bundle.main.url(forResource: fileName, withExtension: nil) {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                    audioPlayer?.play()
                } catch {
                    print("Error playing sound")
                }
            }
        }
    
    func detectFall(with acceleration: CMAcceleration) {
           if let lastAcceleration = lastAcceleration {
               let accelerationDelta = sqrt(pow(acceleration.x - lastAcceleration.x, 2) + pow(acceleration.y - lastAcceleration.y, 2) + pow(acceleration.z - lastAcceleration.z, 2))
               isFallDetected = accelerationDelta > 2.5 // Threshold for fall detection, you can adjust this
           }
           lastAcceleration = acceleration
       }
    
    func stopMotionUpdates() {
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
        motionManager.stopMagnetometerUpdates()
        pedometer.stopUpdates()
    }
}
