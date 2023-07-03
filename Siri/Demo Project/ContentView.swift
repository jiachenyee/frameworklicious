//
//  ContentView.swift
//  DemoApp
//
//  Created by Rizal Hilman on 02/07/23.
//

import SwiftUI
import AppIntents

struct ContentView: View {
    @StateObject var colorSession: MultipeerSession
    @AppStorage("ticker") var selectedStock: String = "AAPL"
    @State private var stock: StockAsset?
    
    var body: some View {
        VStack {
            Spacer()
            Text("Take a look at the demo Shortcuts!")
            ShortcutsLink()
            
            Divider()
            
            HStack {
                Text("Choose stock")
                Spacer()
                Picker("My stock", selection: $selectedStock) {
                    ForEach(stockAssets, id: \.ticker) { stock in
                        Text(stock.name)
                    }
                }
                .onChange(of: selectedStock) { newValue in
                    self.stock = stockAssets.first { stockAsset in
                        stockAsset.ticker == newValue
                    }
                }
                
            }
            
            if let stockAsset = stock {
                MyStockView(entity: stockAsset)
            }
            
            Divider()
            Text("Connected Devices:")
            Text(String(describing: colorSession.connectedPeers.map(\.displayName)))
            
            Spacer()
        }
        .onAppear {
            AppShortcuts.updateAppShortcutParameters()
        }
        .padding()
        .background((colorSession.currentColor.map(\.color) ?? .clear).ignoresSafeArea())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(colorSession: MultipeerSession.shared)
    }
}

extension NamedColor {
    var color: Color {
        switch self {
        case .red:
            return .red
        case .green:
            return .green
        case .yellow:
            return .yellow
        }
    }
}
