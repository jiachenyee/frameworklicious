//
//  Case1View.swift
//  Demo Project
//
//  Created by Gerson Janhuel on 25/06/23.
//

import SwiftUI


struct Case1View: View {
    @EnvironmentObject var hapticsManager: HapticsManager
    
    var body: some View {
        VStack {
            HStack {
                SampleView(haptic: .sparkle)
                SampleView(haptic: .heartbeats)
            }
            
            HStack {
                SampleView(haptic: .boing)
                SampleView(haptic: .inflate)
            }
            
            HStack {
                SampleView(haptic: .gravel)
                SampleView(haptic: .rumble)
            }
            
            HStack {
                SampleView(haptic: .drums)
                SampleView(haptic: .lamborghini)
            }
            
        }
        .navigationTitle("Custom Haptic Samples")
        .onAppear {
            hapticsManager.prepareHaptics()
        }
        
    }
}


struct SampleView: View {
    var haptic: HapticSample
    
    @EnvironmentObject var hapticsManager: HapticsManager
    
    var body: some View {
        Button {
            hapticsManager.playHapticSample(haptic)
        } label: {
            ZStack {
                Rectangle()
                    .frame(width: 140, height: 140)
                    .foregroundColor(Color("lightGray"))
                    .cornerRadius(15)
                switch haptic {
                case .drums, .lamborghini:
                    Text("\(haptic.rawValue) (♫)")
                        .foregroundColor(.white)
                default:
                    Text(haptic.rawValue)
                        .foregroundColor(.white)
                }
                
            }
        }
        .padding()
    }
}


struct Case1View_Previews: PreviewProvider {
    static var previews: some View {
        Case1View()
    }
}
