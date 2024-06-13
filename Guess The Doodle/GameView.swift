//
//  GameView.swift
//  Guess The Doodle
//
//  Created by salih kocatürk on 13.06.2024.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var MatchManager: MatchManager
    @State var drawingGuess = ""
    @State var eraserEnabled = ""
    func makeGuess(){
        //TODO: Submit to guess
        
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(MatchManager: MatchManager())
    }
}
