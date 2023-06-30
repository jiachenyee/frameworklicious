//
//  SharePlayActivity.swift
//  TarikUlur
//
//  Created by Muhammad Tafani Rabbani on 12/06/23.
//

import Foundation
import GroupActivities

struct SharePlayActivity: GroupActivity {

    var metadata: GroupActivityMetadata {
        var meta = GroupActivityMetadata()
        meta.title = NSLocalizedString("SharePlay Example", comment: "")
        meta.type = .generic
        return meta
    }
}

enum GameState {
    case playerOneWon
    case playerTwoWon
    case playing

    var title: String? {
        switch self {
        case .playerOneWon:
            return "Player Red Won!"
        case .playerTwoWon:
            return "Player Blue Won!"
        case .playing:
            return "Still Playing"
        }
    }
}
