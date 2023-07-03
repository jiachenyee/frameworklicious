//
//  StartViewModel.swift
//  Air Hockey
//
//  Created by Muhammad Irfan on 29/06/23.
//

import MultipeerConnectivity

enum ConnectionStatus {
    case notHosting
    case waitingPlayers
    case playerComplete
}

class StartViewModel: NSObject, ObservableObject {
    @Published var player1: Player = Player(color: .yellow)
    @Published var player2: Player = Player(color: .red)
    @Published var connectionStatus: ConnectionStatus = .notHosting
    @Published var availablePlayers: [Player] = []
    @Published var gameState: GameState = .waiting
    @Published var multipeerHandler: MultipeerHandler = MultipeerHandler()
    
    override init() {
        super.init()
    }
    
    func startHosting() {
        multipeerHandler.delegate = self
        multipeerHandler.startAdvertiseAndBrowse()
        connectionStatus = .waitingPlayers
        player1.isSearching = true
        player2.isSearching = true
    }
    
    func stopHosting() {
        multipeerHandler.stopAdvertiseAndDC()
        player1 = Player(color: .yellow)
        player2 = Player(color: .red)
        connectionStatus = .notHosting
        availablePlayers = []
        gameState = .waiting
    }
    
    func startGame(){
        multipeerHandler.sendGameState(state: .play) { success in
            if success {
                self.gameState = .play
            }
        }
    }
}

extension StartViewModel: MultipeerHandlerDelegate {
    func didReceive(data: Data, from peerID: MCPeerID) {
        
    }
    
    func lostPeer(peerID: MCPeerID) {
        DispatchQueue.main.async {
            self.availablePlayers.removeAll(where: { $0.peerID?.displayName == peerID.displayName })
        }
    }
    
    func foundPeer(peerID: MCPeerID) {
        DispatchQueue.main.async {
            if !self.availablePlayers.contains(where: { $0.peerID?.displayName == peerID.displayName }) {
                let player = Player(color: .black, peerID: peerID)
                self.availablePlayers.append(player)
            }
        }
    }
    
    func assignPlayer(peerID: MCPeerID) {
        guard player1.peerID?.displayName != peerID.displayName && player2.peerID?.displayName != peerID.displayName else {
            return
        }
        
        DispatchQueue.main.async { [self] in
            if (player1.peerID != nil) {
                if(player2.peerID != nil){
                    player1 = player2
                    player1.color = .yellow
                    player2 = Player(color: .red, peerID: peerID)
                    multipeerHandler.sendPlayerNumberData(playerNum: .player1, peerID: peerID)
                    multipeerHandler.sendPlayerNumberData(playerNum: .player2, peerID: peerID)
                } else {
                    player2 = Player(color: .red, peerID: peerID)
                    multipeerHandler.sendPlayerNumberData(playerNum: .player2, peerID: peerID)
                }
            } else {
                player1 = Player(color: .yellow, peerID: peerID)
                multipeerHandler.sendPlayerNumberData(playerNum: .player1, peerID: peerID)
            }
            
            if player2.peerID != nil {
                connectionStatus = .playerComplete
            }
            
        }
    }
    
    func removePlayer(peerID: MCPeerID){
        DispatchQueue.main.async { [self] in
            if (player1.peerID?.displayName == peerID.displayName) {
                if (player2.peerID != nil) {
                    player1 = player2
                    player2 = Player(color: .red, isSearching: true)
                } else {
                    player1 = Player(color: .yellow, isSearching: true)
                }
            } else if (player2.peerID?.displayName == peerID.displayName) {
                player2 = Player(color: .red, isSearching: true)
            }
            connectionStatus = .waitingPlayers
        }
    }
}




