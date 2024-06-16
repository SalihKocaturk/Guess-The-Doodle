//
//  SignInView.swift
//  Guess The Doodle
//
//  Created by salih kocatürk on 16.06.2024.
//

import SwiftUI

struct SignInView: View {
    @StateObject var matchManager =  MatchManager()
    var body: some View {
        ZStack{
            if matchManager.isGameOver{
                GameOverView(MatchManager: matchManager)
            }else if matchManager.inGame{
                GameView(MatchManager: matchManager)
            }else{
                MenuView(MatchManager: matchManager)
            }
        }.onAppear{
            matchManager.authanticateUser()
        }
    }
}
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
