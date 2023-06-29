//
//  DialView.swift
//  Demo Project
//
//  Created by Dini on 27/06/23.
//

import Foundation
import SwiftUI

struct DialView: View {

    let goal: Int
    let steps: Int

    var body: some View {
        ZStack {
            CircleView()
            
            ZStack {
                CircleView()

                Circle().stroke(style: StrokeStyle(lineWidth: 12))
                    .padding(20)
                    .foregroundColor(.foregroundGray)

                Circle()
                    .trim(from: 0, to: (CGFloat(steps) / CGFloat(goal)))
                    .scale(x: -1)
                    .rotation(.degrees(90))
                    .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round))
                    .padding(20)
                    .foregroundColor(.blueColor)

                VStack {
                    Text("Weekly Goal: \(goal)")
                        .font(.title2)
                        .padding(.bottom)
                    Text("This Week steps:")

                    Text("\(steps)")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom)
                }
                .foregroundColor(.blueColor)
            }
            .padding()
        }
        .foregroundColor(.accentColor)
    }

}

