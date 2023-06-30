//
//  RegularSpringView.swift
//  SwiftAnimation
//
//  Created by Norman Mukhallish on 29/06/23.
//

import SwiftUI

struct RegularSpringView: View {
    @State private var isPlaying = false
    @State private var transparency: Double = 0.0
    var body: some View {
        VStack{
            Button{
                isPlaying.toggle()
                transparency = 0.6
                withAnimation(.easeOut(duration: 0.2)){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                        transparency = 0.0
                    }
                }
            } label: {
                ZStack{
                    Circle()
                        .frame(width: 90, height: 90)
                        .opacity(transparency)
                    
                    Image(systemName: "pause.fill")
                        .font(.system(size: 64))
                        .scaleEffect(isPlaying ? 1 : 0)
                        .opacity(isPlaying ? 1 : 0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isPlaying)
                    
                    Image(systemName: "play.fill")
                        .font(.system(size: 64))
                        .scaleEffect(isPlaying ? 0 : 1)
                        .opacity(isPlaying ? 0 : 1)
                        .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isPlaying)
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct RegularSpringView_Previews: PreviewProvider {
    static var previews: some View {
        RegularSpringView()
    }
}
