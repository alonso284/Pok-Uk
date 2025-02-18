//
//  Croupier.swift
//  Pok'Uk
//
//  Created by Alonso Huerta on 17/01/25.
//

import SwiftUI

extension Game {
    
    var croupierText: String {
        if let _ = pokerEngine.playerHand, let _ = pokerEngine.dealerHand {
            return pokerEngine.buttonMessage
        }
        else {
            if pokerEngine.bet == 0 {
                return "Place a bet to play."
            } else {
                if pokerEngine.playerSelected > 0 {
                    return "Draw to change the selected cards"
                } else {
                    return "Hold to keep all current cards."
                }
            }
        }
    }
    
    var Options: some View {
        VStack {
            TextBox(text: croupierText)
            HStack(spacing: 0) {
                TextBox(text: "True", color: Color("TreesLight"), multplier: 0.5)
                TextBox(text: "False", color: Color("Accent"), multplier: 0.5)
                
            }
            .opacity(0)
        }
        .padding(.top)
    }
    
    var Croupier: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            VStack(spacing: 0) {
                Spacer()
                HStack(spacing: 0) {
                    Spacer()
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 400)
                    Options
                        .padding(.trailing, 50)
                    Spacer()
                    Spacer()
                }
                
            }
        }
    }
    
    var image: String {
        switch pokerEngine.endGameState {
        case .win:
            return "lose"
        case .lose:
            return "win"
        case .draw:
            return "thinking"
        case .none:
            if pokerEngine.bet == 0 {
                return "thinking"
            }
            return "idle"
        }
    }
}
