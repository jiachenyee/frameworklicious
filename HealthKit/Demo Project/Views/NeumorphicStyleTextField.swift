//
//  NeumorphicStyleTextField.swift
//  Demo Project
//
//  Created by Dini on 27/06/23.
//

import Foundation
import SwiftUI

struct NeumorphicStyleTextField: View {
    var textField: TextField<Text>
    
    var body: some View {
        HStack {
            textField
                .foregroundColor(.blueColor)
            }
            .padding()
            .foregroundColor(.neumorphictextColor)
            .background(Color.background)
            .cornerRadius(6)
            .shadow(color: Color.darkShadow, radius: 3, x: 2, y: 2)
            .shadow(color: Color.lightShadow, radius: 3, x: -2, y: -2)
        }
}

