//
//  GameOverView.swift
//  Guess The Doodle
//
//  Created by salih kocatürk on 12.06.2024.
//

import SwiftUI

struct GameOverView: View {
    @ObservedObject var MatchManager : MatchManager
    var body: some View {
        VStack
         {
             Spacer()
             Image("gameOver")
                 .resizable()
                 .scaledToFit()
                 .padding(.horizontal , 70)
                 .padding(.vertical)
             Text("score:  \(MatchManager.score)").font(.largeTitle).bold().foregroundColor(Color("primaryYellow"))
             
             Spacer()
             ButtonView(str: .constant("PLAY"), color1: .constant(Color.yellow), color2: .constant(Color.yellow), color3: .constant(Color.yellow))

                 .renameAction {
                     MatchManager.resetGame()
                 //addaction
             }
             .padding(.vertical, 20)
                 .padding(.horizontal, 100)
                 .disabled(MatchManager.authenticationState != .authenticated || MatchManager.inGame)
             Text(MatchManager.authenticationState.rawValue).font(.headline.weight(.semibold))
                 .foregroundColor(Color("primaryYellow"))
                 .padding()
             Spacer()
         }.background(Image("gameOverBg").resizable()
             .scaledToFit()
             .scaleEffect(1.2)
         ).ignoresSafeArea()
       
     }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(MatchManager: MatchManager())
    }
}
