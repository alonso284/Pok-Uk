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
            return pokerEngine.croupierMessage
        }
        else {
            if pokerEngine.bet == 0 {
                if pokerEngine.bet + pokerEngine.points <= 0 {
                    return "You’re out of tokens!"
                } else {
                    return "Place a bet to play."
                }    
            } else {
                return "Let's play!"
            }
        }
    }
    
    var Options: some View {
        VStack(spacing: 10) {
            if let trivia = pokerEngine.fact {
                CustomTextBox(text: "Take the trivia to reclaim your tokens!", height: 60, width: 380, textSize: 20, backgroundColor: Color("Base"), strokeSize: 2)
                TextBox(text: pokerEngine.feedback ?? trivia.fact, textSize: 20, height: 200)
                if pokerEngine.feedback == nil {
                    HStack(spacing: 10) {
                        Button(action: {
                            pokerEngine.answerTrivia(answer: true)
                        }, label: {
                            CustomTextBox(text: "True", textColor: .white, height: 60, width: .infinity, textSize: 25, backgroundColor: Color("TreesLight"), strokeSize: 2)
                        })
                        Button(action: {
                            pokerEngine.answerTrivia(answer: false)
                        }, label: {
                            CustomTextBox(text: "False", textColor: .white, height: 60, width: .infinity, textSize: 25, backgroundColor: Color("Accent"), strokeSize: 2)
                        })
                        
                    }.frame(width: 380)
                } else {
                    Button(action: {
                        pokerEngine.endTrivia()
                    }, label: {
                        CustomTextBox(text: "Continue", height: 60, width: .infinity, textSize: 20, strokeSize: 2)
                    })
                    .disabled(pokerEngine.givingTriviaReward)
                    .frame(width: 380)
                }
            } else {
                TextBox(text: croupierText)
            }
        }
        .frame(width: 350)
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
                    Image(
                        pokerEngine.fact == nil ? image :
                        (pokerEngine.emote == nil ? "thinking" :
                        (pokerEngine.emote! ? "win" : "lose"))
                    )
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
