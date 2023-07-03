//
//  ContentView.swift
//  Demo Project
//
//  Created by Jia Chen Yee on 12/06/23.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    var healthStore: HealthStore?
    
    @State var steps: [Steps] = [Steps]()
    @State var goals: Int = 0
    @State var isPresented: Bool = false
    @State var isModal: Bool = false
    
    var totalSteps: Int {
        steps.map { $0.count }.reduce(0,+)
    }
    
    init() {
        healthStore = HealthStore()
    }

    var body: some View {
        NavigationStack{
            VStack {
                VStack{
                    Text("HealthKit: Steps")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.blueColor)
                        .padding()
                    
                    Button("Add Weekly Goal") {
                        self.isPresented = true
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .tint(.blueColor)
                }
                .sheet(isPresented: $isPresented){
                    AddGoalView(goals: self.$goals, isPresented: self.$isPresented)
                }
                
                DialView(goal: self.goals, steps: totalSteps)
                    .padding(10)
                
                VStack{
                    Button("Weekly summary") {
                        self.isModal = true
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .tint(.blueColor)
                }
                .sheet(isPresented: $isModal){
                    GraphView(isModal: self.$isModal, steps: steps)
                }
            }
            .padding()
            .background(Color.backgroundGray)
        }
        .onAppear {
            if let healthStore = healthStore {
                healthStore.requestAuthorization { success in
                    if success {
                        healthStore.calculateSteps { statisticsCollection in
                            if let statisticsCollection = statisticsCollection {
                                updateUIFromStatistics(statisticsCollection)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        let startDate = Calendar.current.date(byAdding: .day, value: -6, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            let step = Steps(count: Int(count ?? 0), date: statistics.startDate)
            steps.append(step)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DialView(goal: 2000, steps: 200)
    }
}
