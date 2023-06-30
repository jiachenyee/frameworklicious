//
//  ChartCustomAnimateView.swift
//  SwiftAnimation
//
//  Created by Muhammad Afif Maruf on 27/06/23.
//

import SwiftUI

struct ChartCustomAnimateView: View {
    @State var pickerState: PickerState = .weekday
    @State private var useInteractiveSpring = true
    
    var body: some View {
        ZStack {
            Color.mint.edgesIgnoringSafeArea(.all)
            
            VStack {
                // Title
                Text("Calorie Intake")
                    .font(.system(size: 34))
                    .fontWeight(.heavy)
                // Picker
                Picker(selection: $pickerState, label: Text("")) {
                    ForEach(PickerState.allCases, id: \.self){ picker in
                        Text(picker.description).tag(picker)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                // Graph
                HStack(spacing: 20) {
                    ForEach(Weekday.allCases, id: \.self) { day in
                        BarView(value: getRandomData(pickerState: pickerState), day: day)
                    }
                }
                .animation(useInteractiveSpring ? .interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.0) : .easeInOut, value: pickerState)
                
                Toggle(isOn: $useInteractiveSpring) {
                    Text("Interactive Spring")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.black)
                        .padding()
                }
                .padding(20)
            }
        }
        
    }
    //func to random data
    func getRandomData(pickerState: PickerState) -> CGFloat {
        switch pickerState {
        case .weekday, .afternoon, .evening: return CGFloat.random(in: 0...180)
        }
    }
}

struct BarView: View {
    let value: CGFloat
    let day: Weekday
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                // Background
                Capsule().frame(width: 30, height: 200)
                    .foregroundColor(.black)
                // Foreground
                Capsule().frame(width: 30, height: value)
                    .foregroundStyle(Color.green.gradient)
            }
            Text(day.description)
                .bold()
                .padding(.top, 8)
        }
    }
}

enum PickerState: CaseIterable {
    case weekday
    case afternoon
    case evening
    
    var description: String {
        switch self {
        case .weekday: return "Weekday"
        case .afternoon: return "Afternoon"
        case .evening: return "Evening"
        }
    }
}

enum Weekday: Int, CaseIterable {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    
    var description: String {
        switch self {
        case .sunday: return "Su"
        case .monday: return "M"
        case .tuesday: return "T"
        case .wednesday: return "W"
        case .thursday: return "Th"
        case .friday: return "F"
        case .saturday: return "Sa"
        }
    }
}

struct ChartCustomAnimateView_Previews: PreviewProvider {
    static var previews: some View {
        ChartCustomAnimateView()
    }
}
