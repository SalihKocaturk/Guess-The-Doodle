//
//  MatchManager.swift
//  Guess The Doodle
//
//  Created by salih kocatürk on 12.06.2024.
//

import Foundation
import GameKit
import PencilKit
import GameController

class MatchManager: NSObject, ObservableObject{
   
    
    
    @Published var inGame = false
    @Published var isGameOver =  false
    @Published var authenticationState = PlayerAuthState.authenticating
    
    @Published var currentlyDrawing = false
    @Published var drawPrompt = ""
    @Published var pastGuesses = [PastGuess]()
   
    @Published var score = 0
    @Published var remainingTime = maxTimeRemaining
    
    //MatchMaking Vars
    var match: GKMatch?
    var otherPlayer: GKPlayer?
    var localPlayer: GKLocalPlayer?
    var playerUUIDKey = UUID().uuidString
    var rootViewController: UIViewController? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }
    func authanticateUser(){
        GKLocalPlayer.local.authenticateHandler = { vc, e in
            self.LocalPlayerService(vc: vc, e: e)
        }
    }
    func LocalPlayerService(vc:UIViewController?, e:Error?){
        if let viewController = vc {
            rootViewController?.present(viewController, animated: true)
            return
        }
        if let error = e{
            authenticationState = .error
            print(error.localizedDescription)
            return
        }
        if ((localPlayer?.isAuthenticated) != nil) {
            if ((localPlayer?.isMultiplayerGamingRestricted) != nil){
                authenticationState = .restricted
            }else{
                authenticationState = .authenticated
            }
        }else{
            authenticationState = .unauthenticated
        }
    }
    func startMatchMaking(){
        let request = GKMatchRequest()
        request.maxPlayers = 2
        request.minPlayers = 2
        let matchMakingViewController = GKMatchmakerViewController(matchRequest: request)
        matchMakingViewController?.matchmakerDelegate = self
        rootViewController?.present(matchMakingViewController!, animated: true)
    }
    func startGame(newMatch: GKMatch){
        match = newMatch
        match?.delegate = self
    }
}
