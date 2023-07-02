//
//  AnimatableWay.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 18/06/23.
//

import SwiftUI

struct AnimationDataMonitorView: View, Animatable {
    static var timestamp = Date()
    var number: Double
    var animatableData: Double { // When rendering, SwiftUI detects that this view is Animatable and continues to call animableData based on the values provided by the timing curve function after the state has changed.
        get { number }
        set { number = newValue }
    }

    var body: some View {
        let duration = Date().timeIntervalSince(Self.timestamp).formatted(.number.precision(.fractionLength(3)))
        
        VStack {
            HStack {
                Text("Time lapsed: ")
                Spacer()
                Text("\(duration) seconds")
            }
            
            HStack {
                Text("Time Algo: ")
                Spacer()
                Text(number, format: .number.precision(.fractionLength(3)))
            }
        }
    }
}

struct AnimatableWay: View {
    @State var startAnimation = false
        var body: some View {
            VStack {
                AnimationDataMonitorView(number: startAnimation ? 10 : 0) // Declare the two states
                    .animation(.easeOut(duration: 10), value: startAnimation) // Associate dependencies and timing curve functions
                Button("Show Data") {
                    AnimationDataMonitorView.timestamp = Date()
                    startAnimation.toggle() // Change dependencies
                }
            }
            .frame(width: 300, height: 300)
        }
}

struct AnimatableWay_Previews: PreviewProvider {
    static var previews: some View {
        AnimatableWay()
    }
}
