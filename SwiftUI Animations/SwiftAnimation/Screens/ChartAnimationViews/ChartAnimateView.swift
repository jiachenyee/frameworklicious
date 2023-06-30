//
//  ChartAnimateView.swift
//  SwiftAnimation
//
//  Created by Muhammad Afif Maruf on 27/06/23.
//

import SwiftUI
import Charts

struct ChartAnimateView: View {
    @State var sampleData : [ChartExampleModel] = []
    @State var currentTab : String = "7 Days"
    @State private var useSpring = true
    
    var body: some View {
        VStack(alignment: .center){
            Spacer()
            Text("Swift Chart Animation")
                .font(.title)
                .bold()
            Spacer()
            VStack(alignment: .leading, spacing: 12){
                HStack{
                    Text("Views")
                        .fontWeight(.semibold)
                    
                    Picker("", selection: $currentTab) {
                        Text("7 Days")
                            .tag ("7 Days")
                        Text("Week")
                            .tag ("Week")
                        Text("Month")
                            .tag ("Month")
                    }
                    .pickerStyle(.segmented)
                    .padding(.leading, 80)
                }
                
                let totalValue = sampleData.reduce(0.0){partialResult, item in
                    item.views + partialResult
                }
                
                Text(totalValue.stringFormat)
                    .font(.largeTitle.bold())
                //Chart Animation
                AnimatedChart()
            }
            Spacer()
            Toggle(isOn: $useSpring) {
                Text("Toggle Spring")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.black)
                    .padding()
            }
            .padding(20)
        }
        .padding(20)
        .onAppear{
            generateRandomData()
        }
        .onChange(of: currentTab) { newValue in
            generateRandomData()
            for (index, _) in sampleData.enumerated(){
                sampleData[index].views = .random(in: 1500...10000)
            }
            
            //re-animating view
            animateGraph(fromChange: true)
        }
    }
    
    @ViewBuilder
    func AnimatedChart() -> some View{
        let max = sampleData.max { item1, item2 in return item2.views > item1.views
        }?.views ?? 0
        
        Chart{
            ForEach(sampleData) { item in
                BarMark(
                    x: .value("Hour", item.hour, unit: .hour),
                    y: .value("Views", item.animate ? item.views : 0)
                )
                .foregroundStyle(Color.mint.gradient)
            }
        }
        .chartYScale(domain: 0...(max + 2000))
        .frame(height: 250)
        .onAppear{
            animateGraph()
        }
    }
    
    func generateRandomData() {
            // Generate random SiteViewModel instances
            sampleData = (8..<21).map{ hour in
                ChartExampleModel(hour: Date().updateHour(value: hour), views: .random(in: 1500...10000), animate: false)
            }
        }
    
    func animateGraph(fromChange: Bool = false){
        for (index,_) in sampleData.enumerated(){
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * (fromChange ? 0.03 : 0.05)){
                withAnimation(useSpring ? .spring(response: 0.8, dampingFraction: 0.6, blendDuration: 0.8) : .easeInOut (duration: 0.8)){
                    sampleData[index].animate = true
                }
            }
        }
    }
}

struct ChartAnimateView_Previews: PreviewProvider {
    static var previews: some View {
        ChartAnimateView()
    }
}
