//
//  InterpolatingSpringView.swift
//  SwiftAnimation
//
//  Created by Norman Mukhallish on 29/06/23.
//

import SwiftUI

struct InterpolatingSpringView: View {
    @State private var showReaction = false
    var body: some View {
        VStack{
            ZStack{
                Rectangle()
                    .frame(width: 200, height: 40)
                    .cornerRadius(20)
                    .opacity(0.7)
                    .scaleEffect(showReaction ? 1 : 0, anchor: .topTrailing)
                    .animation(.interpolatingSpring(stiffness: 200, damping: 12).delay(0), value: showReaction)
                HStack{
                    Text("❤️")
                        .offset(x: showReaction ? 0 : -15)
                        .scaleEffect(showReaction ? 1 : 0, anchor: .bottomLeading)
                        .rotationEffect(.degrees(showReaction ? 0 : -45))
                        .animation(.interpolatingSpring(stiffness: 170, damping: 8).delay(0.1), value: showReaction)
                    Text("👍")
                        .offset(x: showReaction ? 0 : -15)
                        .scaleEffect(showReaction ? 1 : 0, anchor: .bottomLeading)
                        .rotationEffect(.degrees(showReaction ? 0 : -45))
                        .animation(.interpolatingSpring(stiffness: 170, damping: 8).delay(0.2), value: showReaction)
                    Text("👎")
                        .offset(x: showReaction ? 0 : -15)
                        .scaleEffect(showReaction ? 1 : 0, anchor: .bottomLeading)
                        .rotationEffect(.degrees(showReaction ? 0 : -45))
                        .animation(.interpolatingSpring(stiffness: 170, damping: 8).delay(0.3), value: showReaction)
                    Text("🙂")
                        .offset(x: showReaction ? 0 : -15)
                        .scaleEffect(showReaction ? 1 : 0, anchor: .bottomLeading)
                        .rotationEffect(.degrees(showReaction ? 0 : -45))
                        .animation(.interpolatingSpring(stiffness: 170, damping: 8).delay(0.4), value: showReaction)
                    Text("🙁")
                        .offset(x: showReaction ? 0 : -15)
                        .scaleEffect(showReaction ? 1 : 0, anchor: .bottomLeading)
                        .rotationEffect(.degrees(showReaction ? 0 : -45))
                        .animation(.interpolatingSpring(stiffness: 170, damping: 8).delay(0.5), value: showReaction)
                }
            }.padding()
            
            
            Text("Tap Here")
                .font(.system(size: 36, weight: .bold))
                .onTapGesture {
                    showReaction.toggle()
                }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct InterpolatingSpringView_Previews: PreviewProvider {
    static var previews: some View {
        InterpolatingSpringView()
    }
}
