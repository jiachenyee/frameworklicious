//
//  SpringView.swift
//  SwiftAnimation
//
//  Created by Norman Mukhallish on 29/06/23.
//

import SwiftUI

struct SpringView: View {
    @State private var isHidden = false
    var body: some View {
        VStack{
            ZStack{
                
                Image(systemName: "heart.fill")
                    .scaleEffect(isHidden ? 4 : 0)
                    .foregroundColor(isHidden ? .red : .gray)
                    .opacity(isHidden ? 1 : 0)
                
                Image(systemName: "heart")
                    .scaleEffect(isHidden ? 0 : 4)
                    .foregroundColor(isHidden ? .red : .gray)
                    .opacity(isHidden ? 0 : 1)
                

                
            }.padding(30)
            .onTapGesture {
                withAnimation(.interactiveSpring()){
                    isHidden.toggle()

                }
            }
            
            Text("Interactive Spring Animation")
                .font(.system(size: 18, weight: .bold))
            
            
        }.edgesIgnoringSafeArea(.all)
    }
}

struct SpringView_Previews: PreviewProvider {
    static var previews: some View {
        SpringView()
    }
}
