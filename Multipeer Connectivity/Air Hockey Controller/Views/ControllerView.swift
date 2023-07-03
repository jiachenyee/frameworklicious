//
//  ContentView.swift
//  Air Hockey Controller
//
//  Created by Muhammad Irfan on 15/06/23.
//

import SwiftUI
import CoreMotion

struct ControllerView: View {
    @StateObject private var viewModel: ControllerViewModel
    
    init(multipeerHandler: ControllerMultipeerHandler, parentViewModel: StartControllerViewModel) {
        _viewModel = StateObject(wrappedValue: ControllerViewModel(multipeerHandler: multipeerHandler, parentViewModel: parentViewModel) )
    }
    
    var body: some View {
        VStack(spacing: 30) {
            Text("PLAYER \(viewModel.parentViewModel?.playerNum?.rawValue ?? 0)")
                .font(.title)
                .padding(.top, 20.0)
            Text("This side up")
                .font(.body)
            Spacer()
            
            if (viewModel.motionManager.isAccelerometerAvailable) {
                Text("Coordinate: \(viewModel.movX), \(viewModel.movY)")
                    .font(.title)
                Button("Reset") {
                    viewModel.resetPosition()
                }
            } else {
                Text("No accelerometer data")
                    .font(.title)
            }
            
            Spacer()
            
            Button("End Game") {
                viewModel.endGame()
            }
        }
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
            viewModel.startAccelerometerUpdates()
//            viewModel.startDeviceMotionUpdates()
        }
        .onDisappear {
            UIApplication.shared.isIdleTimerDisabled = false
            viewModel.stopAccelerometerUpdates()
//            viewModel.stopDeviceMotionnUpdates()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ControllerView(multipeerHandler: ControllerMultipeerHandler(), parentViewModel: StartControllerViewModel())
    }
}
