//
//  SetupView.swift
//  Demo Project
//
//  Created by Gerson Janhuel on 24/06/23.
//

import SwiftUI

struct SetupView: View {
    @ObservedObject var matchManager: MatchManager
    
    var body: some View {
        ZStack {
            Color("custom-purple")
                .ignoresSafeArea(.all)
            
            VStack {
                //Text("Press Play to start")
                
                Button {
                    matchManager.initiateMatch()
                } label: {
                    Text("Play")
                        .frame(width: 200, height: 70)
                        .font(.system(size: 40).bold().italic())
                        .foregroundColor(Color("custom-purple"))
                }
                //.buttonStyle(.borderedProminent)
                .background(.white)
                .cornerRadius(15)
                .padding()
                
            }
        }
        
        
    }
}

struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        SetupView(matchManager: MatchManager())
    }
}
