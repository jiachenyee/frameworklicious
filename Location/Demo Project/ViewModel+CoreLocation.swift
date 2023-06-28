//
//  ViewModel+CoreLocation.swift
//  Demo Project
//
//  Created by Dini on 28/06/23.
//

import Foundation
import CoreLocation

extension ViewModel: CLLocationManagerDelegate {
    
    func startMonitoring() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            let constraint = CLBeaconIdentityConstraint(uuid: .init(uuidString: "1D8123E8-E703-4FE8-AB73-14EFB3B3EA40")!, major: 1)
            manager.startRangingBeacons(satisfying: constraint)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        let beaconRegion = region as? CLBeaconRegion

        if state == .inside {
            manager.startRangingBeacons(satisfying: beaconRegion!.beaconIdentityConstraint)
        } else {
            manager.stopRangingBeacons(satisfying: beaconRegion!.beaconIdentityConstraint)
        }
        manager.startRangingBeacons(satisfying: beaconRegion!.beaconIdentityConstraint)
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didRange beacons: [CLBeacon],
                         satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        
        //case unknown = 0
        //case immediate = 1 <0.5m
        //case near = 2 <14.5m
        //case far = 3
        
        for beacon in beacons {
            if let beaconIndex = nearbyBeacons.firstIndex(where: {
                $0.minor == beacon.minor
            }) {
                nearbyBeacons[beaconIndex] = beacon
                
            } else {
                nearbyBeacons.append(beacon)
            }
        }
    }
}

