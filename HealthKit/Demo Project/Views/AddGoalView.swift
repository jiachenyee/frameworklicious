//
//  AddGoalView.swift
//  Demo Project
//
//  Created by Dini on 27/06/23.
//

import Foundation
import SwiftUI

struct AddGoalView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Binding var goals: Int
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            ZStack {
                Color.background.ignoresSafeArea()
                VStack(alignment: .leading) {
                    Text("Weekly Goal Steps").font(.title2).foregroundColor(Color.blueColor)
                        .fontWeight(.semibold)
                        .padding(.bottom)
                    HStack {
                        NeumorphicStyleTextField(textField: TextField("Search...", text: Binding(get: {String(goals)}, set: {goals = Int($0) ?? 0 })))
                    }
                    .keyboardType(.decimalPad)
                    
                    Button("Save Goal"){
                        self.isPresented = false
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .padding(.top)
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .tint(Color.blueColor)
                }.padding()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct AddGoalView_Previews: PreviewProvider {
    static var previews: some View {
        AddGoalView(goals: .constant(0), isPresented: .constant(false))
    }
}
