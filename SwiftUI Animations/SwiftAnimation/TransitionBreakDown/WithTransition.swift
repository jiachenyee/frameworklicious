//
//  WithTransition.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 21/06/23.
//

import SwiftUI

struct MyTransition: ViewModifier { // The wrapper object for the custom transition needs to conform to the ViewModifier protocol
    let rotation: Angle
    func body(content: Content) -> some View {
        content
            .rotationEffect(rotation) // animatable component
    }
}

extension AnyTransition {
    static var rotation: AnyTransition {
        AnyTransition.modifier(
            active: MyTransition(rotation: .degrees(360)),
            identity: MyTransition(rotation: .zero)
        )
    }
}

struct WithTransition: View {
    @State var show = true
       var body: some View {
           VStack {
               VStack {
                   Spacer()
                   Text("Hello")
                   if show {
                       Text("World")
                           .transition(.rotation.combined(with: .opacity))
                   }
                   Spacer()
               }
               .animation(.easeInOut(duration: 2), value: show) // declare animation here, the text of the Button will not have animation effect
               Button(show ? "Hide" : "Show") {
                   show.toggle()
               }
           }
   //        .animation(.easeInOut(duration: 2), value: show) // if declared here, the text of the Button will also be affected, resulting in the following image
           .frame(width: 300, height: 300)
           .onChange(of: show) {
               print($0)
           }
       }
}

struct WithTransition_Previews: PreviewProvider {
    static var previews: some View {
        WithTransition()
    }
}
