//
//  MatchManager.swift
//  Demo Project
//
//  Created by Gerson Janhuel on 24/06/23.
//

import SwiftUI
import GameKit

enum UserAuthenticationState: String {
    case authenticating = "Logging to Game Center..."
    case authenticated = "Good to go!"
    case unauthenticated = "Please sign in to Game Center!"
    case error = "There was an error logging to Game Center."
    case restricted = "You're restricted to play game."
}

enum GameStatus {
    case setup
    case inGame
    case gameOver
}

class MatchManager: NSObject, ObservableObject {
    @Published var authStatus: UserAuthenticationState = .authenticating
    @Published var gameStatus: GameStatus = .setup
    
    var match: GKMatch?
    var otherPlayer: GKPlayer?
    var localPlayer = GKLocalPlayer.local
    
    @Published var myAvatar = Image(systemName: "person.crop.circle")
    @Published var opponentAvatar = Image(systemName: "person.crop.circle")
    
    let gameDuration = 15 // in seconds 
    var tapScore: Int = 0
    var otherPlayerScore: Int = 0
    
    @Published var isLocalPlayerWin = false
    @Published var isDraw = false
    
    
    var rootViewController: UIViewController? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }
    
    func authenticateUser() {
        
        GKLocalPlayer.local.authenticateHandler = { [self] vc, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                authStatus = .error
                return
            }
            
            if GKLocalPlayer.local.isAuthenticated {
                authStatus = .authenticated
                self.localPlayer = GKLocalPlayer.local
                
                // Load the local player's avatar.
                GKLocalPlayer.local.loadPhoto(for: GKPlayer.PhotoSize.small) { image, error in
                    if let image {
                        self.myAvatar = Image(uiImage: image)
                    }
                    if let error {
                        // Handle an error if it occurs.
                        print("Error: \(error.localizedDescription).")
                    }
                }
                
            } else {
                authStatus = .unauthenticated
            }
        }
    }
    
    
    func initiateMatch() {
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 2
        
        let matchmakingVC = GKMatchmakerViewController(matchRequest: request)
        matchmakingVC?.matchmakerDelegate = self
        
        rootViewController?.present(matchmakingVC!, animated: true)
    }
    
    func startGame(newMatch: GKMatch) {
        match = newMatch
        match?.delegate = self
        
        if let otherPlayer = match?.players.first {
            self.otherPlayer = otherPlayer
            
            self.otherPlayer?.loadPhoto(for: GKPlayer.PhotoSize.small) { (image, error) in
                if let image {
                    self.opponentAvatar = Image(uiImage: image)
                }
                if let error {
                    print("Error: \(error.localizedDescription).")
                }
            }
        }
        
        // reset
        tapScore = 0
        otherPlayerScore = 0
        isDraw = false
        isLocalPlayerWin = false
        
        // back in game
        gameStatus = .inGame
    }
    
    
    func openLeaderboard() {
        let gameCenterVC = GKGameCenterViewController(leaderboardID: "godsfingerleaderboard", playerScope: .global, timeScope: .today)
        gameCenterVC.gameCenterDelegate = self
        rootViewController?.present(gameCenterVC, animated: true)
    }
    
    func submitMyScoreToGameCenterLeaderboard(_ score: Int) {
        GKLeaderboard.submitScore(score, context: 0, player: localPlayer, leaderboardIDs: ["godsfingerleaderboard"]) { [self] error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            gameStatus = .gameOver
        }
    }
    
    func endGame(withScore score: Int) {
        tapScore = score
        
        // send data to other player
        sendString("playerScore:\(score)")
        
        submitMyScoreToGameCenterLeaderboard(score)
    }
    
    func updateOtherPlayerScore(withScore score: Int) {
        
        otherPlayerScore = score
        isLocalPlayerWin = tapScore > otherPlayerScore
        isDraw = tapScore == otherPlayerScore
    }
    
    func receivedStringData(_ message: String) {
        let messageSplit = message.split(separator: ":")
        
        let score = Int(messageSplit.last ?? "0") ?? 0
        
        updateOtherPlayerScore(withScore: score)
    }
}
