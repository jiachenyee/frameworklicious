//
//  ListOfAnimationView.swift
//  SwiftAnimation
//
//  Created by Norman Mukhallish on 29/06/23.
//

import SwiftUI

struct ListOfAnimationView: View {
    @State private var isTapped = false
    var body: some View {
        NavigationView{
            
            List{
                
                NavigationLink(destination: EaseView()){
                    Text("Ease Animation")
                }
                NavigationLink(destination: RegularSpringView()){
                    Text("Spring Animation")
                }
                NavigationLink(destination: SpringView()){
                    Text("Interactive Spring Animation")
                }
                NavigationLink(destination: InterpolatingSpringView()){
                    Text("Interpolating Spring Animation")
                }
                
                
            }.navigationTitle("Swift Animation")
            
            
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ListOfAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfAnimationView()
    }
}
