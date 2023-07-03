//
//  MultipeerHandler.swift
//  Air Hockey
//
//  Created by Muhammad Irfan on 30/06/23.
//

import MultipeerConnectivity

protocol MultipeerHandlerDelegate: AnyObject {
    func assignPlayer(peerID: MCPeerID)
    func removePlayer(peerID: MCPeerID)
    func foundPeer(peerID: MCPeerID)
    func lostPeer(peerID: MCPeerID)
    func didReceive(data: Data, from peerID: MCPeerID)
}

class MultipeerHandler: NSObject, ObservableObject {
    weak var delegate: MultipeerHandlerDelegate?

    private let myPeerId = MCPeerID(displayName: "Host: \(UIDevice.current.name)")
    private let serviceType = MCConstants.service

    var session: MCSession
    var browser: MCNearbyServiceBrowser
    var advertiser: MCNearbyServiceAdvertiser

    override init() {
        self.session = MCSession(peer: myPeerId, securityIdentity: nil, encryptionPreference: .required)
        self.browser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: serviceType)
        self.advertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: serviceType)
        super.init()

        self.session.delegate = self
        self.browser.delegate = self
        self.advertiser.delegate = self
    }
    
    func startAdvertiseAndBrowse() {
        advertiser.startAdvertisingPeer()
        browser.startBrowsingForPeers()
    }
    
    func stopAdvertiseAndDC() {
        advertiser.stopAdvertisingPeer()
        session.disconnect()
    }
    
    func inviteAndAssignPlayer(peerID: MCPeerID) {
        browser.invitePeer(peerID, to: session, withContext: nil, timeout: 60)
    }
    
    func invitePlayerViaBrowser() {
        let browser = MCBrowserViewController(serviceType: serviceType, session: session)
        browser.maximumNumberOfPeers = 3
        browser.delegate = self
        
        // Get the current window scene
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        
        // Get the windows in the current window scene
        let windows = windowScene?.windows
        
        // Present the browser view controller on the first window
        windows?.first?.rootViewController?.present(browser, animated: true)
    }
    
    
    //Sending Data
    func sendPlayerNumberData(playerNum: PlayerNumber, peerID: MCPeerID) {
        let playerNumData = Data([DataTypeIdentifier.playerNumber.rawValue, UInt8(playerNum.rawValue)])
        
        do {
            try session.send(playerNumData, toPeers: [peerID], with: .reliable)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func sendGameState(state: GameState, completion: @escaping (Bool) -> Void) {
        let gameStateData = Data([UInt8(DataTypeIdentifier.gameState.rawValue), UInt8(state.rawValue)])
        do {
            try session.send(gameStateData, toPeers: session.connectedPeers, with: .reliable)
            completion(true)
        } catch {
            print(error.localizedDescription)
            completion(false)
        }
    }
    
}

extension MultipeerHandler: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connecting:
            print("\(peerID) state: connecting")
        case .connected:
            print("\(peerID) state: connected")
            delegate?.assignPlayer(peerID: peerID)
        case .notConnected:
            print("\(peerID) state: not connected")
            delegate?.removePlayer(peerID: peerID)
        default:
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

extension MultipeerHandler: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        if (!peerID.displayName.contains("Host:")){
            delegate?.foundPeer(peerID: peerID)
        }
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        delegate?.lostPeer(peerID: peerID)
    }
    
    
}

extension MultipeerHandler: MCBrowserViewControllerDelegate {
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true)
    }
    
    
}

extension MultipeerHandler: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        
    }
}
