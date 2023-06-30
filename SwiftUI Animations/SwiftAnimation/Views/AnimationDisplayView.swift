//
//  AnimationDisplayView.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 22/06/23.
//

import SwiftUI

struct AnimationDisplayView<Content:View>: View {
    var content: () -> Content
    
    var body: some View {
        content()
    }
}

struct AnimationDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationDisplayView {
            Text("Hello")
        }
    }
}
