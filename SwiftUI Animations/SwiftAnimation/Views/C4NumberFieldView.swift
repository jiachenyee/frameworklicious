//
//  C4TextField.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 22/06/23.
//

import SwiftUI
import Combine

struct C4NumberField: View {
    @State var publisher = PassthroughSubject<String, Never>()
    @State var debouncedText: String = ""
    var debounceSeconds = 0.5
    
    @Binding var number: String
    var placeholder: String
    var label: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
            
            TextField(placeholder, text: $debouncedText)
                .keyboardType(.decimalPad)
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(.black, lineWidth: 1)
                )
                .onChange(of: debouncedText) { value in
                    publisher.send(value)
                }
                .onReceive(Just(debouncedText), perform: { newValue in
                    let filtered = newValue.filter { "-0123456789.,".contains($0) }
                    
                    if filtered != newValue {
                        debouncedText = filtered
                    }
                })
                .onReceive(
                    publisher.debounce(for: .seconds(debounceSeconds), scheduler: DispatchQueue.main)) { value in
                       number = value
                    }
        }
        .onAppear{
            debouncedText = number
        }
        .onChange(of: number) { newValue in
            if debouncedText != number {
                debouncedText = number
            }
        }
    }
}

struct C4TextField_Previews: PreviewProvider {
    static var previews: some View {
        C4NumberField(number: .constant("0"), placeholder: "Your text here", label: "Test")
    }
}

