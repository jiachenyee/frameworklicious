//
//  ChartExampleModel.swift
//  SwiftAnimation
//
//  Created by Muhammad Afif Maruf on 27/06/23.
//

import Foundation
//Model Data
struct ChartExampleModel: Identifiable{
    var id: String = UUID().uuidString
    var hour: Date
    var views: Double
    var animate: Bool = false
}
