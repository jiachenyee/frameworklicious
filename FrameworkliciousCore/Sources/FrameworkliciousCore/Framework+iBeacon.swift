//
//  File.swift
//  
//
//  Created by Jia Chen Yee on 19/06/23.
//

import Foundation
import CoreLocation

@available(iOS 16.0, *)
extension Framework {
    init?(from beacon: CLBeaconRegion) {
        guard let intValue = beacon.minor?.intValue else { return nil }
        
        self = Self.all[intValue]
    }
}
