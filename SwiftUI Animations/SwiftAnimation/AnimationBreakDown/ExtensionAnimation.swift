//
//  ExtensionAnimation.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 19/06/23.
//

import SwiftUI

extension Animation {
    static func ripple() -> Animation {
        Animation
            .spring(
                response:0.5,
                dampingFraction: 0.5
            )
            .repeatForever()
    }
}

struct ExtensionAnimation: View {
    @State var animated = false
    
    var body: some View {
        VStack {
            Text("This is the text")
                .offset(x: animated ? 0 : 150)
            
            Circle()
                .fill(.blue)
                .frame(width: 50, height: 50)
                .offset(x: animated ? 0 : 150)
                .animation(.ripple(), value: animated)
               
            Button {
                animated.toggle()
            } label: {
                Text("Animate")
            }
        }
    }
}

struct ExtensionAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ExtensionAnimation()
    }
}
