//
//  WithAnimation.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 17/06/23.
//

import SwiftUI

struct WithAnimation: View {
    @State var animated = false
    
    var body: some View {
        VStack {
            Text("This is the text")
                .offset(x: animated ? 0 : 150)
            
            Circle()
                .fill(.blue)
                .frame(width: 50, height: 50)
                .offset(x: animated ? 0 : 150)
//                .animation(.linear, value: animated)
               
            Button {
                withAnimation {
                    animated.toggle()
                }
                
//                animated.toggle()
            } label: {
                Text("Animate")
            }
        }
    }
}

struct WithAnimation_Previews: PreviewProvider {
    static var previews: some View {
        WithAnimation()
    }
}
