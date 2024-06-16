//
//  MenuView.swift
//  Guess The Doodle
//
//  Created by salih kocatürk on 12.06.2024.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var MatchManager: MatchManager
    var str = "PLAY"
    var body: some View {
       
       VStack
        {
            Spacer()
            Image("logo")
                .resizable()
                .scaledToFit()
                .padding(30)
            Spacer()
            ButtonView(str: .constant("PLAY"), color1: .constant(Color.blue), color2: .constant(Color.yellow), color3: .constant(Color.blue))
                .renameAction {
                    MatchManager.startMatchMaking()
                //addaction
            }.padding(.vertical, 20)
                .padding(.horizontal, 100)
                .disabled(MatchManager.authenticationState != .authenticated || MatchManager.inGame)
            Text(MatchManager.authenticationState.rawValue).font(.headline.weight(.semibold))
                .foregroundColor(Color("primaryYellow"))
                .padding()
            Spacer()
        }.background(Image("menuBg").resizable()
            .scaledToFit()
            .scaleEffect(1.2)
        ).ignoresSafeArea()
      
    }
    
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(MatchManager: MatchManager())
    }
}
