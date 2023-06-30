//
//  ViewIdentifier.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 21/06/23.
//

import SwiftUI

struct ViewIdentifier: View {
    @State var show = false
    
    var body: some View {
        VStack {
            VStack {
                // Code One
                VStack {
                    if show {
                        Text("Code One")  // Branch One
                    } else {
                        Text("Code One")  // Branch Two
                          .offset(y : 100)
                    }
                }

                // Code Two
                Text("Code Two")
                    .offset(y : show ? 100 : 0)  // Two states of the same view are declared
            }
            
            Spacer()
            
            Button {
                show.toggle()
            } label: {
                Text("Change")
            }
        }
        .frame(height: 300)
    }
}

struct ViewIdentifier_Previews: PreviewProvider {
    static var previews: some View {
        ViewIdentifier()
    }
}
