//
//  matchManager+gkMatchDelegate.swift
//  Guess The Doodle
//
//  Created by salih kocatürk on 16.06.2024.
//

import Foundation
import GameKit
extension MatchManager: GKMatchDelegate {
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        <#code#>
    }
    func sendString(_ message: String ) {
        
    }
    func sendData(_ data: Data, mode: GKMatch.SendDataMode){
        
    }
    func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState) {
        <#code#>
    }
}
