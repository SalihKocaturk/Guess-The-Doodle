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
    func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState) {
        guard state == .disconnected && isGameOver == true else{return}
        let alert = UIAlertController(title: "Player Left", message: "Your Enemy Left The Game!", preferredStyle: .alert)
        let OkButton = UIAlertAction(title: "OK", style: .default){  _ in self.match?.disconnect()}
        alert.addAction(OkButton)
        DispatchQueue.main.async {
            self.resetGame()
            self.rootViewController?.present(alert, animated: true)
        }
    }
}
