//
//  Player.swift
//  Air Hockey
//
//  Created by Muhammad Irfan on 29/06/23.
//

import Foundation
import SwiftUI
import MultipeerConnectivity

struct Player: Identifiable {
    var id = UUID()
    var color: Color
    var peerID: MCPeerID?
    var isSearching: Bool = false
}

enum PlayerNumber: Int {
    case player1 = 1
    case player2 = 2
}
