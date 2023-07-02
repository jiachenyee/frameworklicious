//
//  Date+Extension.swift
//  SwiftAnimation
//
//  Created by Muhammad Afif Maruf on 27/06/23.
//

import SwiftUI

extension Date{
    // MARK: To Update Date For Particular Hour
    func updateHour (value: Int) -> Date{
        let calendar = Calendar.current
        return calendar.date(bySettingHour: value, minute: 0, second: 0, of: self) ?? .now
    }
}
