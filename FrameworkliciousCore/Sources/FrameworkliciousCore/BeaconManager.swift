//
//  BeaconManager.swift
//  ExploreAbility Beacon
//
//  Created by Jia Chen Yee on 26/4/23.
//

import Foundation
import CoreBluetooth
import CoreLocation

let beaconUUID = UUID(uuidString: "1D8123E8-E703-4FE8-AB73-14EFB3B3EA40")!

@available(iOS 16.0, *)
class BeaconManager: NSObject, ObservableObject, CBPeripheralManagerDelegate {
    var peripheralManager: CBPeripheralManager!
    var beaconRegion: CLBeaconRegion!
    var peripheralData: NSDictionary!
    
    @Published var isActive = false {
        didSet {
            if !isActive {
                peripheralManager.stopAdvertising()
            }
        }
    }
    
    override init() {
        super.init()
        
    }
    
    func setUp(framework: Framework) {
        beaconRegion = .init(uuid: beaconUUID,
                             major: 1,
                             minor: framework.index,
                             identifier: framework.name)
        
        peripheralData = beaconRegion.peripheralData(withMeasuredPower: nil)
        
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)

    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            peripheralManager.startAdvertising(peripheralData as! [String : Any]?)
            isActive = true
            print("Powered on")
        } else if peripheral.state == .poweredOff {
            isActive = false
        }
    }
}
