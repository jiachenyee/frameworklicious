//
//  PositionPromptView.swift
//  MyApp
//
//  Created by Tomas Martins on 25/09/22.
//

import SwiftUI

struct MyStockView: View {
    var entity: StockAsset = .init(name: "NVidia",
                                         ticker: "NVDA",
                                         currentValue: 1200)

    var body: some View {
        HStack {
            Image(entity.ticker)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40)
            Text(entity.ticker)
                .bold()
                .font(.system(.body,
                              design: .rounded))
            
            Spacer()
                Text("$\(String(format: "%.2f", entity.currentValue))")
                    .font(.system(.title,
                              design: .rounded))
                    .bold()
            Image(systemName: "chart.line.uptrend.xyaxis")
                .foregroundColor(.green)
                .bold()
        }.padding()
    }
}

struct MyStockView_Previews: PreviewProvider {
    static var previews: some View {
        MyStockView(entity: .init(name: "NVidia",
                                  ticker: "NVDA",
                                  currentValue: 1200))
    }
}
