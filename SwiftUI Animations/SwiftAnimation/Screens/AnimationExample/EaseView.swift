//
//  EaseView.swift
//  SwiftAnimation
//
//  Created by Norman Mukhallish on 29/06/23.
//

import SwiftUI

struct EaseView: View {
    @State private var moving = false
    var body: some View {
        
        VStack{
            HStack{
                Text("EaseIn Animation")
                Spacer()
                Circle()
                    .offset(x: moving ? -100 : 0)
                    .animation(Animation.easeIn(duration: 1).repeatForever(), value: moving)
                    .frame(width: 30, height: 30)
            }.padding()
                .onAppear{
                    moving.toggle()
                }
            HStack{
                Text("EaseOut Animation")
                Spacer()
                Circle()
                    .offset(x: moving ? -100 : 0)
                    .animation(Animation.easeOut(duration: 1).repeatForever(), value: moving)
                    .frame(width: 30, height: 30)
            }.padding()
                .onAppear{
                    moving.toggle()
                }
            HStack{
                Text("EaseInOut Animation")
                Spacer()
                Circle()
                    .offset(x: moving ? -100 : 0)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(), value: moving)
                    .frame(width: 30, height: 30)
            }.padding()
                .onAppear{
                    moving.toggle()
                }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct EaseView_Previews: PreviewProvider {
    static var previews: some View {
        EaseView()
    }
}
