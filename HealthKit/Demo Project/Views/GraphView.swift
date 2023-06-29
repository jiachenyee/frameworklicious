//
//  GraphView.swift
//  Demo Project
//
//  Created by Dini on 27/06/23.
//

import Foundation
import SwiftUI

struct GraphView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Binding var isModal: Bool

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter
    }()
    
    let steps: [Steps]
    var totalSteps: Int {
        steps.map { $0.count }.reduce(0,+)
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .lastTextBaseline) {
                
                ForEach(steps, id: \.id) { step in
                    let yValue = Swift.min(step.count/20, 300)
                    VStack {
                        Text("\(step.count)")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.blueColor)
                        
                        RoundedRectangle(cornerRadius: 6)
                            .fill(step.count > 3000 ? Color.greenGraph : Color.redGraph)
                            .frame(width: 20, height: CGFloat(yValue))
                            .shadow(color: .foregroundGray, radius: 2, x: 5, y: 5)
                            .shadow(color: .white, radius: 2, x: -5, y: -5)
                            .padding(.bottom)
                            .foregroundColor(.blueColor)
                        
                        Text("\(step.date,formatter: Self.dateFormatter)")
                            .font(.caption)
                            .foregroundColor(.blueColor)
                    }
                }
            }
            
            Text("Total Steps this week: \n\(totalSteps)")
                .multilineTextAlignment(.center)
                .padding(.top, 100)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.blueColor)
            
            Button("Back"){
                self.isModal = false
                self.presentationMode.wrappedValue.dismiss()
            }
            .padding(.top)
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(Color.blueColor)
            
            
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(10)
        .padding(10)
        .background(Color.backgroundGray)
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        
        let steps = [
                   Steps(count: 3452, date: Date()),
                   Steps(count: 123, date: Date()),
                   Steps(count: 3452, date: Date()),
                   Steps(count: 1223, date: Date()),
                   Steps(count: 5223, date: Date()),
                   Steps(count: 1223, date: Date()),
                   Steps(count: 12023, date: Date())
               ]
        
        GraphView(isModal: .constant(false), steps: steps)
    }
}

