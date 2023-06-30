//
//  C4Picker.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 24/06/23.
//

import SwiftUI

struct C4Picker<State:Hashable, Options:View>: View {
    @Binding var value: State
    
    let segmented: Bool
    let label:String
    let options: () -> Options
    
    init(value: Binding<State>, segmented: Bool = false, label: String, options: @escaping () -> Options) {
        _value = value
        
        self.segmented = segmented
        self.label = label
        self.options = options
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
            
            Picker(label, selection: $value) {
               options()
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 4)
            .background(
                Rectangle()
                    .stroke(.black, lineWidth: segmented ? 0 : 1)
            )
        }
    }
}

struct C4Picker_Previews: PreviewProvider {
    static var previews: some View {
        C4Picker(value: .constant("blabla"), label: "hehe") {
            Group {
                Text("aahaha").tag(1)
                Text("hohoho").tag(2)
                Text("hohaho").tag(3)
                Text("hohoha").tag(4)
                Text("hihohi").tag(5)
            }
        }
    }
}
