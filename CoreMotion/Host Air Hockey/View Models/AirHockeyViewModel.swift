//
//  AirHockeyViewModel.swift
//  Air Hockey
//
//  Created by Muhammad Irfan on 30/06/23.
//

import Foundation
import SwiftUI
import MultipeerConnectivity

class AirHockeyViewModel: ObservableObject {
    weak var parentViewModel: StartViewModel?
    
    @Published var multipeerHandler: MultipeerHandler
    @Published var puckPosition = CGPoint(x: 384, y: 512)
    @Published var puckVelocity = CGVector(dx: 6, dy: 6)
    
    @Published var player1Position: CGPoint = .zero
    @Published var player2Position: CGPoint = .zero
    
    @Published var showAlert = false
    @Published var disconnectedPlayer: MCPeerID?
    
    @Published var player1Score = 0
    @Published var player2Score = 0
    @Published var winner: String?
    @Published var showAlertWin = false
    
    let paddleSize: CGSize
    let puckSize: CGSize
    
    var player1Translation: CGSize = .zero
    var player2Translation: CGSize = .zero
    
    var maxPlayerMovement: CGFloat = UIScreen.main.bounds.height/2
    
    var geometriSize: CGSize?
    
    private var timer: Timer?
    
    init(multipeerHandler: MultipeerHandler, parentViewModel: StartViewModel?, paddleSize: CGSize = CGSize(width: 120, height: 40), puckSize: CGSize = CGSize(width: 40, height: 40)) {
        self.multipeerHandler = multipeerHandler
        self.paddleSize = paddleSize
        self.puckSize = puckSize
        startPuckMovementTimer()
        self.multipeerHandler.delegate = self
        self.parentViewModel = parentViewModel
    }
    
    func startPuckMovementTimer() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            self?.movePuck()
        }
        self.timer?.tolerance = 0.01
    }
    
    private func movePuck() {
        let newPuckX = puckPosition.x + puckVelocity.dx
        let newPuckY = puckPosition.y + puckVelocity.dy
        
        // Check collision with player 1
        let player1Rect = CGRect(x: player1Position.x - paddleSize.width/2, y: player1Position.y - paddleSize.height/2, width: paddleSize.width, height: paddleSize.height)
        if player1Rect.contains(CGPoint(x: newPuckX, y: newPuckY)) {
            let relativeIntersectX = player1Position.x - newPuckX
            let normalizedRelativeIntersectionX = relativeIntersectX / (paddleSize.width / 2)
            let bounceAngle = normalizedRelativeIntersectionX * CGFloat.pi / 4
            let magnitude = sqrt(pow(puckVelocity.dx, 2) + pow(puckVelocity.dy, 2))
            puckVelocity.dx = magnitude * cos(bounceAngle)
            puckVelocity.dy = -magnitude * sin(bounceAngle)
        }
        
        // Check collision with player 2
        let player2Rect = CGRect(x: player2Position.x - paddleSize.width/2, y: player2Position.y - paddleSize.height/2, width: paddleSize.width, height: paddleSize.height)
        if player2Rect.contains(CGPoint(x: newPuckX, y: newPuckY)) {
            let relativeIntersectX = player2Position.x - newPuckX
            let normalizedRelativeIntersectionX = relativeIntersectX / (paddleSize.width / 2)
            let bounceAngle = normalizedRelativeIntersectionX * CGFloat.pi / 4
            let magnitude = sqrt(pow(puckVelocity.dx, 2) + pow(puckVelocity.dy, 2))
            puckVelocity.dx = magnitude * cos(bounceAngle)
            puckVelocity.dy = magnitude * sin(bounceAngle)
        }
        
        // Check collision with walls
                if newPuckX - puckSize.width/2 <= 0 || newPuckX + puckSize.width/2 >= UIScreen.main.bounds.width {
                    puckVelocity.dx *= -1
                }
        
        // Check collision with goals (top and bottom of screen)
        if newPuckY - puckSize.height/2 <= 0 {
            puckVelocity.dy *= -1
            player2Score += 1 // player 2 scores a point if puck hits top of screen
            checkWinning()
        } else if newPuckY + puckSize.height/2 >= UIScreen.main.bounds.height {
            puckVelocity.dy *= -1
            player1Score += 1 // player 1 scores a point if puck hits bottom of screen
            checkWinning()
        }
        
        puckPosition = CGPoint(x: newPuckX, y: newPuckY)
    }
    
    func resetScore() {
        player1Score = 0
        player2Score = 0
        winner = nil
        showAlertWin = false
    }
    
    func checkWinning() {
        if player1Score == 5 {
            winner = "player 1"
            showAlertWin = true
        } else if player2Score == 5 {
            winner = "player 2"
            showAlertWin = true
        }
    }
    
    func updatePlayer1Position(with translation: CGSize) {
        let newPosition = CGPoint(x: player1Position.x + translation.height,
                                  y: player1Position.y + translation.width)
        
        // Ensure the paddle remains within the game area
        let clampedX = min(max(newPosition.x, paddleSize.width / 2), geometriSize!.width - paddleSize.width / 2)
        let clampedY = min(max(newPosition.y, paddleSize.height / 2), maxPlayerMovement - paddleSize.height)
        
        player1Position = CGPoint(x: clampedX, y: clampedY)
    }
    
    func updatePlayer2Position(with translation: CGSize) {
        let newPosition = CGPoint(x: player2Position.x - translation.height,
                                  y: player2Position.y - translation.width)
        
        // Ensure the paddle remains within the game area
        let clampedX = min(max(newPosition.x, paddleSize.width / 2), geometriSize!.width - paddleSize.width / 2)
        let clampedY = max(min(newPosition.y, geometriSize!.height - paddleSize.height / 2), geometriSize!.height - (maxPlayerMovement - paddleSize.height))
        
        player2Position = CGPoint(x: clampedX, y: clampedY)
    }
    
    func updatePlayerPosition(peerID: MCPeerID, position: Position){
        if (peerID == parentViewModel?.player1.peerID) {
            updatePlayer1Position(with: CGSize(width: position.x, height: position.y))
        } else if (peerID == parentViewModel?.player2.peerID) {
            updatePlayer2Position(with: CGSize(width: position.x, height: position.y))
        }
    }
    
    func resetPosition(peerID: MCPeerID){
        guard let size = geometriSize else {
            return
        }
        if (peerID == parentViewModel?.player1.peerID) {
            player1Position = CGPoint(x: size.width / 2, y: paddleSize.height / 2)
        } else if (peerID == parentViewModel?.player2.peerID) {
            player2Position = CGPoint(x: size.width / 2, y: size.height - paddleSize.height / 2)
        }
    }
    
    func calculatePlayerPosition(from newPosition: CGPoint, in geometry: GeometryProxy) -> CGPoint {
        let x = min(max(newPosition.x, paddleSize.width/2), geometry.size.width - paddleSize.width/2)
        let y = min(max(newPosition.y, paddleSize.height/2), geometry.size.height/2 - paddleSize.height)
        return CGPoint(x: x, y: y)
    }
    
    deinit {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func endGame() {
        parentViewModel?.stopHosting()
        resetScore()
    }
}

extension AirHockeyViewModel: MultipeerHandlerDelegate {
    func assignPlayer(peerID: MCPeerID) {}
    func removePlayer(peerID: MCPeerID) {
        DispatchQueue.main.async {
            self.showAlert = true
            self.disconnectedPlayer = peerID
        }
    }
    
    func foundPeer(peerID: MCPeerID) {}
    func lostPeer(peerID: MCPeerID) {}
    
    func didReceive(data: Data, from peerID: MCPeerID) {
        print("did receive \(data)")
        DispatchQueue.main.async {
            guard let typeIdentifierRawValue = data.first,
                  let typeIdentifier = DataTypeIdentifier(rawValue: typeIdentifierRawValue)
            else { return }
            
            switch typeIdentifier {
            case .position:
                let positionData = data.dropFirst()
                if let position = Position.from(data: positionData) {
                    // Do something with the received position
                    print("Received position: \(position)")
                    self.updatePlayerPosition(peerID: peerID, position: position)
                }
            case .positionReset:
                self.resetPosition(peerID: peerID)
            default:
                print("unidentified data")
            }
        }
    }
}
