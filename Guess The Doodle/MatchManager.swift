//
//  MatchManager.swift
//  Guess The Doodle
//
//  Created by salih kocatürk on 12.06.2024.
//

import Foundation

class MatchManager: ObservableObject {
    @Published var inGame = false
    @Published var isGameOver =  false
    @Published var authenticationState = PlayerAuthState.authenticating
    
    @Published var currentlyDrawing = false
    @Published var drawPrompt = ""
    @Published var pastGuesses = [PastGuess]()
   
    @Published var score = 0
    @Published var remainingTime = maxTimeRemaining
}
