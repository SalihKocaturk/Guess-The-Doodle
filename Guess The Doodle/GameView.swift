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
        ZStack {
            GeometryReader{_ in
                Image(MatchManager.currentlyDrawing ? "drawBg": "guesserBg").resizable().ignoresSafeArea().scaledToFill()
                    .scaleEffect(1.2)
            }
            VStack(){
               topBar
            Spacer()
            }
            
        }
      
    }
    var topBar: some View {
        ZStack(){
            HStack(spacing: 0.0){
                Button{
                    
                    
                }label: {
                    Image(systemName: "arrowshape.turn.up.left.circle.fill")
                        .font(.largeTitle)
                        .tint(Color(MatchManager.currentlyDrawing ? "primaryYellow": "primaryPurple"))
                        
                }
                Spacer()
                Label("\(MatchManager.remainingTime)", systemImage: "clock.fill").bold().font(.title2)
                
            }
            
        }
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(MatchManager: MatchManager())
    }
}
