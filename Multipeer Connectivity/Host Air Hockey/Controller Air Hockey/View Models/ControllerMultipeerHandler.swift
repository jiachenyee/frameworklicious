//
//  ControllerMultipeerHandler.swift
//  Air Hockey Controller
//
//  Created by Muhammad Irfan on 30/06/23.
//

import MultipeerConnectivity

protocol ControllerMultipeerHandlerDelegate: AnyObject {
    func connected(peerID: MCPeerID)
    func disconnected(peerID: MCPeerID)
    func didReceive(data: Data, from peerID: MCPeerID)
}

class ControllerMultipeerHandler: NSObject, ObservableObject {
    weak var delegate: ControllerMultipeerHandlerDelegate?
    
    private let myPeerId = MCPeerID(displayName: String("\(UIDevice.current.name) \(UUID())".prefix(10)))
    private let serviceType = MCConstants.service
    var session: MCSession
    var browser: MCNearbyServiceBrowser
    var advertiser: MCNearbyServiceAdvertiser
    private var hostPeerID: MCPeerID? //I want to save the peerID of host
    
    override init() {
        self.session = MCSession(peer: myPeerId, securityIdentity: nil, encryptionPreference: .required)
        self.browser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: serviceType)
        self.advertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: serviceType)
        super.init()
        
        self.session.delegate = self
        self.advertiser.delegate = self
    }
    
    func startAdvertising() {
        advertiser.startAdvertisingPeer()
    }
    
    func stopAdvertising() {
        advertiser.stopAdvertisingPeer()
        session.disconnect()
    }
    
    //Sending Data
    func sendPositionData(position: Position) {
        guard let hostPeerID = hostPeerID else { return }
        guard let encodedPosition = position.toJSONData() else {
            print("Failed to encode position")
            return
        }
        
        var positionData = Data([DataTypeIdentifier.position.rawValue])
        positionData.append(encodedPosition)
        
        do {
            try session.send(positionData, toPeers: [hostPeerID], with: .reliable)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func sendResetPosition(){
        guard let hostPeerID = hostPeerID else { return }
        
        var data = Data([DataTypeIdentifier.positionReset.rawValue])
        do {
            try session.send(data, toPeers: [hostPeerID], with: .reliable)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

extension ControllerMultipeerHandler: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connecting:
            print("\(peerID) state: connecting")
        case .connected:
            print("\(peerID) state: connected")
            if (peerID.displayName.contains("Host:")){
                hostPeerID = peerID
            }
            delegate?.connected(peerID: peerID)
        case .notConnected:
            print("\(peerID) state: not connected")
            delegate?.disconnected(peerID: peerID)
        @unknown default:
            print("\(peerID) state: unknown")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        delegate?.didReceive(data: data, from: peerID)
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    
}

extension ControllerMultipeerHandler: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, session)
    }
}

