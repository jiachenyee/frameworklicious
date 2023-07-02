//
//  ViewModel.swift
//  Demo Project
//
//  Created by Dini on 28/06/23.
//

import Foundation
import CoreLocation

class ViewModel: NSObject, ObservableObject {
    
    let locationManager = CLLocationManager()
    @Published var nearbyBeacons: [CLBeacon] = []
    
    override init() {
        super.init()
        
        startMonitoring()
    }
}

