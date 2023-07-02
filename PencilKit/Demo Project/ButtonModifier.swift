//
//  ButtonModifier.swift
//  PencilKitDemo290623
//
//  Created by Afina R. Vinci on 02/07/23.
//

import SwiftUI

struct TopButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 30, height: 30)
            .padding(10)
            .background(.white)
            .cornerRadius(20)
    }
}
