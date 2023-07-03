//
//  AppShortcuts.swift
//  DemoApp
//
//  Created by Rizal Hilman on 02/07/23.
//

import AppIntents
import SwiftUI

struct AppShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: FirstAppIntent(),
            phrases: [
                "Say hi with \(.applicationName)",
            ]
        )
        
        AppShortcut(
            intent: GreetIntent(),
            phrases: [
                "Greeting with \(.applicationName)"
            ]
        )
        
        AppShortcut(
            intent: ShowMyStockIntent(),
            phrases: [
                "Show my stock \(.applicationName)"
            ]
        )
        
        AppShortcut(
            intent: AppleStockIntent(),
            phrases: [
                "\(.applicationName) change stock to Apple"
            ]
        )
        
        AppShortcut(
            intent: MicrosoftStockIntent(),
            phrases: [
                "\(.applicationName) change stock to Microsoft"
            ]
        )
    }
}


struct FirstAppIntent: AppIntent {
    static var title: LocalizedStringResource {
        "My first intent"
    }
    
    func perform() async throws -> some IntentResult {
        
        return .result(dialog: "Hello there! this is your first app intent!")
    }
}

struct GreetIntent: AppIntent {

    @Parameter(title: "Type your name")
    var name: String
    
    static var parameterSummary: some ParameterSummary {
        Summary("Say greeting message to \(\.$name)")
    }
    
    static var title: LocalizedStringResource {
        "Greeting someone"
    }
    
    func perform() async throws -> some IntentResult {
        return .result(dialog: "Welcome, \(name) 👋")
    }
    
}


struct ShowMyStockIntent: AppIntent {
    
    var selectedStock: String? =  UserDefaults.standard.string(forKey: "ticker")
    
    static var title: LocalizedStringResource {
        "My stock intent"
    }
    
    func perform() async throws -> some IntentResult {
        
        let stock = stockAssets.first { stockAsset in
            stockAsset.ticker == selectedStock ?? "NVDIA"
        }
        
        return .result(dialog: "You currently position at \(stock!.ticker) is worth $\(String(format: "%.2f", stock!.currentValue))", view: MyStockView(entity: stock!))
    }
}


struct AppleStockIntent: AppIntent {
    
    var selectedStock: String = "AAPL"
    
    static var title: LocalizedStringResource {
        "My stock intent"
    }
    
    func perform() async throws -> some IntentResult {
        MultipeerSession.shared.send(color: .red)
        UserDefaults.standard.set(selectedStock, forKey: "ticker")
        
        let stock = stockAssets.first { stockAsset in
            stockAsset.ticker == selectedStock
        }
        
        
        return .result(dialog: "You stock has been change to \(stock!.ticker)!", view: MyStockView(entity: stock!))
    }
}

struct MicrosoftStockIntent: AppIntent {
    
    var selectedStock: String = "MSFT"
    
    static var title: LocalizedStringResource {
        "My stock intent"
    }
    
    func perform() async throws -> some IntentResult {
        MultipeerSession.shared.send(color: .yellow)
        UserDefaults.standard.set(selectedStock, forKey: "ticker")
        
        let stock = stockAssets.first { stockAsset in
            stockAsset.ticker == selectedStock
        }
        
        
        return .result(dialog: "You stock has been change to \(stock!.ticker)!", view: MyStockView(entity: stock!))
    }
}
