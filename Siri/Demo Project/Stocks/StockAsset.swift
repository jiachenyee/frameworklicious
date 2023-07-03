//
//  StockAsset.swift
//  DemoApp
//
//  Created by Rizal Hilman on 02/07/23.
//
import Foundation


var stockAssets: [StockAsset] {
    [
        .init(name: "Apple", ticker: "AAPL", currentValue: 1200),
        .init(name: "Microsoft", ticker: "MSFT", currentValue: 800),
        .init(name: "NVidia", ticker: "NVDA", currentValue: 400)
    ]
}

struct StockAsset: Hashable {
    var id = UUID()
    var name: String
    var ticker: String
    var currentValue: Double
    
    init(name: String, ticker: String, currentValue: Double) {
        self.name = name
        self.ticker = ticker
        self.currentValue = currentValue
    }
}
