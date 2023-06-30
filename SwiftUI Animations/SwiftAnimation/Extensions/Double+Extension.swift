//
//  Double+Extension.swift
//  SwiftAnimation
//
//  Created by Muhammad Afif Maruf on 27/06/23.
//

import SwiftUI

extension Double{
    var stringFormat: String{
        if self >= 10000 && self < 999999{
            return String(format: "%.1fK", self/1000).replacingOccurrences(of: ".0", with: "")
        }
        if self > 999999{
            return String(format: "%.1fM", self/1000000).replacingOccurrences(of: ".0", with: "")
        }
        return String(format: "%.1f", self)
    }
}
