//
//  CountdownView.swift
//  Demo Project
//
//  Created by Jia Chen Yee on 20/06/23.
//

import SwiftUI

struct CountdownView: View {
    
    @Binding var state: UserState
    
    @State private var number = 3
    @State private var scale = 20.0
    
    @State private var color = Color.red
    
    var body: some View {
        Text("\(number)")
            .font(.largeTitle)
            .fontWeight(.bold)
            .scaleEffect(scale)
            .foregroundStyle(color)
            .onAppear {
                withAnimation(.easeOut(duration: 1)) {
                    scale = 0.5
                    color = color.opacity(0)
                }
                
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                    number = 2
                    scale = 20.0
                    color = .yellow
                    
                    withAnimation(.easeOut(duration: 1)) {
                        scale = 0.5
                        color = color.opacity(0)
                    }
                    
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                        number = 1
                        scale = 20.0
                        color = .green
                        
                        withAnimation(.easeOut(duration: 1)) {
                            scale = 0.5
                            color = color.opacity(0)
                        }
                        
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                            state = .started
                        }
                    }
                }
            }
    }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView(state: .constant(.countdown))
    }
}
