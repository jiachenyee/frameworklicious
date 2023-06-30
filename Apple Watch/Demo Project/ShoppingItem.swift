//
//  ShoppingItem.swift
//  Connectivity210623
//
//  Created by Afina R. Vinci on 24/06/23.
//

import Foundation

struct ShoppingItem: Identifiable {
    let id = UUID()
    let name: String
    let quantity: Double
    let unit: Unit
    let imageName: String
    var isTaken: Bool = false
    var duration: Double = 0.0
    
    func prinnt() {
        print(self.unit.rawValue)
    }
    
    static func getSampleData() -> [ShoppingItem] {
        return [
            ShoppingItem(name: "Broccoli", quantity: 2.0, unit: .pcs, imageName: "broccoli"),
            ShoppingItem(name: "Ginger", quantity: 100.0, unit: .gram, imageName: "ginger", isTaken: true),
            ShoppingItem(name: "Carrot", quantity: 500.0, unit: .gram, imageName: "carrot"),
            ShoppingItem(name: "Lemon", quantity: 3.0, unit: .pcs, imageName: "lemon"),
            ShoppingItem(name: "Cabbage", quantity: 250.0, unit: .gram, imageName: "cabbage"),
            ShoppingItem(name: "Onion", quantity: 200.0, unit: .gram, imageName: "onion", isTaken: true)
        ]
    }
    
    //create sample data
}

enum Unit: String {
    case pcs
    case gram
    case liter
}


