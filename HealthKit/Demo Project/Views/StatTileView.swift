//
//  StatTileView.swift
//  Demo Project
//
//  Created by Dini on 27/06/23.
//

import Foundation
import SwiftUI

struct StatTile: View {
    let image: String
    let value: String
    let measurement: String

    var body: some View {
        VStack {
            Image(systemName: image)
            Text(value)
                .font(.title)
            Text(measurement)
        }
        .foregroundColor(.accentColor)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15).fill(Color.backgroundGray)
                .shadow(color: .foregroundGray, radius: 3, x: 8, y: 8)
                .shadow(color: .white, radius: 3, x: -8, y: -8)
        )
    }
}
