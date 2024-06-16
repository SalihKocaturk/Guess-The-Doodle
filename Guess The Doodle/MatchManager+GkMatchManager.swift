//
//  MatchManager+GkMatchManager.swift
//  Guess The Doodle
//
//  Created by salih kocatürk on 16.06.2024.
//

import Foundation
import GameKit
extension MatchManager: GKMatchmakerViewControllerDelegate{
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        viewController.dismiss(animated: true)
    }
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        viewController.dismiss(animated: true)
    }
    
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFind match: GKMatch) {
        viewController.dismiss(animated: true)
        startGame(newMatch: match)
    }
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, hostedPlayerDidAccept player: GKPlayer) {
        <#code#>
    }
}
