//
//  GameViewModel.swift
//  TarikUlur
//
//  Created by Muhammad Tafani Rabbani on 12/06/23.
//

import Foundation


import GroupActivities
import SwiftUI

@MainActor
class GameViewModel: ObservableObject {

    @Published private var model: GameModel

    var gameXOffset: Double { model.gameXOffset }
    var isDissable: Int { model.isDissable }
    var playersMovementAmount: Double = 10
    var playerSize: Double { playerRadius * 2 }
    var playerRadius: Double = 25
    


    var gameHoleSize: Double = 280

    var gameState: GameState? {
        switch model.gameXOffset {
        case let offset where offset < -gameHoleSize - playerRadius:
            return .playerOneWon
        case let offset where offset > gameHoleSize + playerRadius:
            return .playerTwoWon
        default:
            return .playing
        }
    }

    init(model: GameModel) {
        self.model = model
    }

    func increaseBallPosition() {
        model.gameXOffset += playersMovementAmount
        send(model)
    }

    func decreaseBallPosition() {
        model.gameXOffset -= playersMovementAmount
        send(model)
    }
    
    func pushTheRope(index : Int){
        model.isDissable = index
        send(model)
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
            self.model.isDissable = 0
            self.send(self.model)
        })
    }

    func resetGame() {
        model.gameXOffset = 0
        send(model)
    }

    var tasks = Set<Task<Void, Never>>()
    var messenger: GroupSessionMessenger?

    func startSharing() {
        Task {
            do {
                _ = try await SharePlayActivity().activate()
            } catch {
                print("Failed to activate SharePlay activity: \(error)")
            }
        }
    }

    func configureGroupSession(_ session: GroupSession<SharePlayActivity>) {
        let messenger = GroupSessionMessenger(session: session)
        self.messenger = messenger

        let task = Task {
            for await (sharePlayModel, _) in messenger.messages(of: GameModel.self) {
                handle(sharePlayModel)
            }
        }
        tasks.insert(task)

        session.join()
    }

    func handle(_ model: GameModel) {
        withAnimation {
            self.model = model
        }
    }

    func send(_ model: GameModel) {
        Task {
            do {
                try await messenger?.send(model)
            } catch {
                print("Send SharePlayModel failed: \(error)")
            }
        }
    }
}
