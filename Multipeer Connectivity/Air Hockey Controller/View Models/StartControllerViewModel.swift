//
//  ControllerViewModel.swift
//  Air Hockey Controller
//
//  Created by Muhammad Irfan on 29/06/23.
//

import SwiftUI
import MultipeerConnectivity

enum ConnectionStatus {
    case notSearching
    case searchingHost
    case waitingHost
}

class StartControllerViewModel: NSObject, ObservableObject {
    @Published var multipeerHandler: ControllerMultipeerHandler = ControllerMultipeerHandler()
    
    @Published var connectionStatus: ConnectionStatus = .notSearching
    @Published var playerColor: Color = .white
    @Published var playerNum: PlayerNumber?
    @Published var gameState: GameState = .waiting
    
    override init() {
        super.init()
        multipeerHandler.delegate = self
        
    }
    
    func joinGame() {
        multipeerHandler.delegate = self
        multipeerHandler.startAdvertising()
        connectionStatus = .searchingHost
    }
    
    func cancelGame() {
        DispatchQueue.main.async { [self] in
            gameState = .waiting
            multipeerHandler.stopAdvertising()
            connectionStatus = .notSearching
            playerColor = .white
        }
    }
}

extension StartControllerViewModel: ControllerMultipeerHandlerDelegate {
    func disconnected(peerID: MCPeerID) {
        
    }
    
    func didReceive(data: Data, from peerID: MCPeerID) {
        DispatchQueue.main.async {
            guard let typeIdentifierRawValue = data.first,
                  let typeIdentifier = DataTypeIdentifier(rawValue: typeIdentifierRawValue)
            else { return }
            
            switch typeIdentifier {
            case .playerNumber:
                if let playerNum = PlayerNumber(rawValue: Int(data[1])) {
                    print("PlayerNumber: \(playerNum)")
                    self.playerNum = playerNum
                    switch playerNum {
                    case .player1:
                        self.playerColor = .yellow
                    case .player2:
                        self.playerColor = .red
                    }
                }
            case .gameState:
                if let gameState = GameState(rawValue: Int(data[1])) {
                    print("GameState: \(gameState)")
                    self.gameState = gameState
                }
            case .colorString:
                if let colorString = String(data: data.dropFirst(), encoding: .utf8) {
                    print("color: \(colorString)")
                    self.playerColor = Color(colorString)
                }
            case .position:
                print("position")
            default:
                print("undidentified")
            }
            
        }
    }
    
    func connected(peerID: MCPeerID) {
        DispatchQueue.main.async {
            self.connectionStatus = .waitingHost
        }
    }
}
