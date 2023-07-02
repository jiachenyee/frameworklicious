//
//  Connectivity.swift
//  Connectivity210623
//
//  Created by Afina R. Vinci on 21/06/23.
//

import Foundation
import WatchConnectivity

struct ItemDataWatch: Hashable {
    var name: String
    var quantity: Double
    var quantityType: String
    var isTaken: Bool
    var imageData: Data
    var createdDate: Date
}

class Connectivity: NSObject, ObservableObject, WCSessionDelegate {
    @Published var receivedText = "nu uh"
    @Published var shoppingItems: [ItemDataWatch] = []
    @Published var updatedItemName = ""
    
    override init() {
        super.init()
        
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func sendFile(_ url: URL) {
        let session = WCSession.default
        if session.activationState == .activated {
            session.transferFile(url, metadata: nil)
        }
    }
    
    func updateTaken() {
        
    }
    
    func transferUserInfo(_ userInfo: [String: Any]) {
        let session = WCSession.default
        if session.activationState == .activated {
            session.transferUserInfo(userInfo)
        }
    }
    
    func sendMessage(_ data: [String: Any]) {
        let session = WCSession.default
        if session.isReachable {
            print("is ")
            session.sendMessage(data) { response in
                DispatchQueue.main.async {
                    self.receivedText = "Received response: \(response)"
                }
            }
        } else {
            print("is not reachable")
        }
    }
    
    func setContext(to data: [String: Any]) {
        let session = WCSession.default
        if session.activationState == .activated {
            do {
                try session.updateApplicationContext(data)
            } catch {
                receivedText = "Alert! Updating app context failed!"
            }
        }
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        print("is receiving user info on ios")
        DispatchQueue.main.async {
            if let updatedItemName = userInfo["updatedItemName"] as? String {
                self.updatedItemName = updatedItemName
            }
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        DispatchQueue.main.async {
            self.receivedText = "Application context received: \(applicationContext)"
        }
    }
    
    #if os(iOS)
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("is receiving on ios")
        DispatchQueue.main.async {
            if let updatedItemName = message["updatedItemName"] as? String {
                self.updatedItemName = updatedItemName
                print("???")
                print(self.updatedItemName)
            }
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        DispatchQueue.main.async {
            if activationState == .activated {
                if session.isWatchAppInstalled {
                    self.receivedText = "Watch app is installed!"
                    print(self.receivedText)
                }
            }
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    #else
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        DispatchQueue.main.async {
            if let name = message["name"] as? String,
               let quantity = message["quantity"] as? Double,
               let quantityType = message["quantityType"] as? String,
               let isTaken = message["isTaken"] as? Bool,
               let imageData = message["imageData"] as? Data,
               let createdDate = message["createdDate"] as? Date {
                let data = ItemDataWatch(name: name, quantity: quantity, quantityType: quantityType, isTaken: isTaken, imageData: imageData, createdDate: createdDate)
                //ItemDataWatch(name: name, isTaken: isTaken)
                print(":data got: \(data)")
                self.shoppingItems.append(data)
                replyHandler(["response": "Be excellent to each other"])
            }
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    #endif
    
}
