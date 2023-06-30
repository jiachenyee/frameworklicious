//
//  C4UseCaseItem.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 28/06/23.
//

import SwiftUI

struct C4UseCaseItem: View {
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(alignment: .center, spacing: 16) {
                Text(label)
                    .font(
                        .system(
                            size: 24,
                            weight: .medium,
                            design: .rounded
                        )
                    )
                    .foregroundColor(Color.white)
            }
            .frame(maxWidth: .infinity, maxHeight: 48)
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(
                Color.cyan
            )
            .cornerRadius(8)
        }

    }
}

struct C4UseCaseItem_Previews: PreviewProvider {
    static var previews: some View {
        C4UseCaseItem(label: "Hello") {
            
        }
    }
}
