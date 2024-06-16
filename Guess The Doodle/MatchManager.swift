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
    @Published var remainingTime = maxTimeRemaining{
        willSet {
            if isTimeKeeper{sendString("timer:\(newValue)")}
            if newValue < 0 {}
        }
    }
    @Published var lastReceivedDrawingData = PKDrawing()
    @Published var isTimeKeeper = false
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
        otherPlayer = match?.players.first
        drawPrompt = everydayObjects.randomElement()!
        sendString("began:\(playerUUIDKey)")
    }
    func swapRoles(){
        score += 1
        currentlyDrawing = !currentlyDrawing
        drawPrompt = everydayObjects.randomElement()!
    }
    func gameOver(){
       isGameOver = true
        match?.disconnect()
    }
    func resetGame(){
        DispatchQueue.main.async {[self] in
            isGameOver = false
            inGame = false
            drawPrompt = ""
            score = 0
            remainingTime = maxTimeRemaining
            lastReceivedDrawingData = PKDrawing()
            
        }
        isTimeKeeper = false
        match?.delegate = nil
        match = nil
        pastGuesses.removeAll()
        playerUUIDKey = UUID().uuidString
    }
    func receivedString(_ message: String){
        let messageSplit = message.split(separator: ":")
        guard let messageProfix = messageSplit.first else {return}
        let parameter = String(messageSplit.last ?? "")
        switch messageProfix{
            
        case "began":
            if playerUUIDKey == parameter{
                playerUUIDKey = UUID().uuidString
                sendString("began:\(playerUUIDKey)")
                break
            }
            currentlyDrawing = playerUUIDKey < parameter
            inGame = true
            isTimeKeeper = currentlyDrawing
            if isTimeKeeper {
                 countDownTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            }
        case "timer":
            remainingTime = Int(parameter) ?? 0
        case "guess":
            var guessCorrect = false
            if parameter.lowercased() == drawPrompt{
                
                sendString("correct:\(parameter)")
                swapRoles()
                guessCorrect = true
                var n = guessCorrect
            }else{
                sendString("incorrect\(parameter)")
            }
            appendPastGuesses(guess: parameter, correct: guessCorrect)
        case "correct":
            swapRoles()
            appendPastGuesses(guess: parameter, correct: true)
        case "incorrect":
            appendPastGuesses(guess: parameter, correct: false)
        default: break
            
        }
    }
    func appendPastGuesses(guess: String, correct: Bool){
        pastGuesses.append(PastGuess(
            message: "\(guess)\(correct ? " was correct! ": "")",
            correct: correct))
    }
}
