//
//  File.swift
//  
//
//  Created by Jia Chen Yee on 19/06/23.
//

import Foundation
import CoreLocation

@available(iOS 16.0, *)
public extension Framework {
    init?(from beacon: CLBeacon) {
        self = Self.all[beacon.minor.intValue]
    }
}
