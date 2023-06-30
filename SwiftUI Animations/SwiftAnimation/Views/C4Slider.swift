//
//  C4Slider.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 22/06/23.
//

import SwiftUI

struct C4Slider: View {
    @Binding var value: CGFloat
    let label: String
    let range: ClosedRange<CGFloat>
    
    init(
        value: Binding<CGFloat>,
        label: String,
        range: ClosedRange<CGFloat> = 0...1
    ) {
        _value = value
        self.label = label
        self.range = range
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
            
            HStack {
                Slider(value: $value, in: range, step: 0.1)
                Text("\(value.formatted())")
            }
        }
    }
}

struct C4Slider_Previews: PreviewProvider {
    static var previews: some View {
        C4Slider(value: .constant(1.0), label: "Opa")
    }
}
