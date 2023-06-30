//
//  WithoutTransition.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 19/06/23.
//

import SwiftUI

struct WithoutTransition: View {
    @State var show = true
    
    var body: some View {
        VStack {
            Spacer()
            Text("Hello")
            
//            if show {
//                Text("World")
//                    .transition(.slide)
//            } Directly without contained in a wrapped will make transition behave wrong in the insertion
            
//            To make it work correctly the inserted view must be wrapped
//            VStack {
//                if show {
//                    Text("World")
//                        .transition(.slide)
//
//                }
//            }
//            .animation(.linear(duration:1), value: show)
            
            Spacer()
            Button(show ? "Hide" : "Show") {
//                withAnimation {
//                    show.toggle()
//                }
                
                show.toggle()
            }
        }
//        Placing animation modifier at the right view tree is important to get the expected transition
//        .animation(.linear(duration:1), value: show)
        .frame(height: 300)
    }
}

struct WithoutTransition_Previews: PreviewProvider {
    static var previews: some View {
        WithoutTransition()
    }
}
