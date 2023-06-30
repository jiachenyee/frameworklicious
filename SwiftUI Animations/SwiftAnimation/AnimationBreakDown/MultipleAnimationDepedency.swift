//
//  MultipleAnimationDepedency.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 18/06/23.
//

import SwiftUI

/// Animation modifier will ignore later animation modifier
///
///     Circle("hallo world!")
///         .offset(x: animated: ? 0 : 70)
///         .animation(.linear(duration: 0.5), value: animated)
///         .animation(.linear(duration: 3), value: size)
///
/// In the example above the last animation configuration is ignored. The animation will be
/// linear in 0.5 sec duration instead of 3 sec
///
struct MultipleAnimationDepedency: View {
    @State var animated = false
    @State var size = 1.0
    
    var body: some View {
        VStack {
            Circle()
                .fill(animated ? .blue : .red)
                .frame(width: 50, height: 50)
                .offset(x: animated ? 0 : 100, y: animated ? -40 : 0)
                .scaleEffect(size)
                .animation(.easeIn(duration: 0.5), value: animated)
//                .animation(.linear(duration: 1), value: size)
            
            Button {
//                withAnimation(.easeIn(duration: 2)) {
//                    animated.toggle()
//                    size = size < 1.5 ? 1.5 : 1.0
//                }
                
                animated.toggle()
                size = size < 1.5 ? 1.5 : 1.0
            } label: {
                Text("Animate")
            }
        }
    }
}

struct MultipleAnimationDepedency_Previews: PreviewProvider {
    static var previews: some View {
        MultipleAnimationDepedency()
    }
}
