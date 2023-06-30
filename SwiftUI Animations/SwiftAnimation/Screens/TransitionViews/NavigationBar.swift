//
//  NavigationBar.swift
//  SwiftAnimation
//
//  Created by Wahyu Alfandi on 29/06/23.
//

import SwiftUI

struct NavigationBar: View {
    var navTitle = ""
    @Binding var hasScrolled:Bool
    @State var showSearch:Bool = false
    @State var showAccount:Bool = false
    
    var body: some View {
        ZStack {
            Color.clear
                .background(.ultraThinMaterial)
                .blur(radius: 10)
                .opacity(hasScrolled ? 1 : 0)
            
            Text(navTitle)
                .animatableFont(size: hasScrolled ? 22 : 34, weight: .bold)
                .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.top, 20)
                .offset(y:hasScrolled ? -4 : 0)
            
            
        }
        .frame(height: hasScrolled ? 44 : 70)
        .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(navTitle: "title", hasScrolled: .constant(false))
            .previewDevice("iPhone 13")
    }
}

