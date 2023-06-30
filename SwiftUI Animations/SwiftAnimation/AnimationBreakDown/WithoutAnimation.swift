//
//  WithoutAnimation.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 17/06/23.
//

import SwiftUI

struct WithoutAnimation: View {
    @State var animated = false
    
    var body: some View {
        VStack {
            Circle()
                .fill(.blue)
                .frame(width: 50, height: 50)
                .offset(x: animated ? 0 : 150)
            
            Button {
                animated.toggle()
            } label: {
                Text("Animate")
            }
        }
    }
}

struct WithoutAnimation_Previews: PreviewProvider {
    static var previews: some View {
        WithoutAnimation()
    }
}
