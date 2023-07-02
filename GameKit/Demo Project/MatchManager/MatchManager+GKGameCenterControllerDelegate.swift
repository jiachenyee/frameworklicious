//
//  MatchManager+GKGameCenterControllerDelegate.swift
//  Demo Project
//
//  Created by Gerson Janhuel on 24/06/23.
//

import Foundation
import GameKit

extension MatchManager: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        rootViewController?.dismiss(animated: true)
    }
}
