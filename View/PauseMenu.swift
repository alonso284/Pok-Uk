//
//  PauseMenu.swift
//  Pok'Uk
//
//  Created by Alonso Huerta on 17/01/25.
//

import SwiftUI

extension Game {
    var PauseMenu: some View {
        ZStack {
            Color.white
            Color("Supplement").opacity(0.8)
            
            VStack {
                Spacer()
                Text(pokerEngine.points + pokerEngine.bet <= 0 ? "Out of Tokens" : "Pok'Uk")
                    .font(.custom("Mayan", size: 80))
                    .foregroundStyle(.white)
                    .padding(.top, 10)
                    .padding(.vertical, 25)
                    .frame(maxWidth: .infinity)
                    .background(Color(pokerEngine.points + pokerEngine.bet <= 0 ? "Accent" : "Supplement").opacity(0.4))
                Spacer()
                Stats
                Spacer()
                OptionButtons
                Spacer()
            }
        }
        .foregroundStyle(.white)
    }
    
    var Stats: some View {
        VStack(alignment: .trailing) {
            HStack {
                Text("Total Hands: "); Spacer(); Text("\(pokerEngine.handsPlayed)")
            }
            .font(.custom("Mayan", size: 40))
//            .frame(width: 300)
            .padding(.vertical)
            Group {
                HStack {
                    Text("Won: "); Spacer(); Text("\(pokerEngine.won)")
                }
                HStack {
                    Text("Lost: "); Spacer(); Text("\(pokerEngine.lost)")
                }
                HStack {
                    Text("Tied: "); Spacer(); Text("\(pokerEngine.drawn)")
                }
            }
            .font(.custom("Mayan", size: 30))
//            .frame(width: 250)
//            .padding(1)
            .padding(.vertical, 1)
        }
        .frame(width: 300)
    }
    
    var OptionButtons: some View {
        ZStack {
            HStack {
                Group {
                    Spacer()
                    Spacer()
                    // Quit
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(Color("Accent"))
                    })
                    Spacer()
                    // Restart
                    Button(action: {
                        pokerEngine.restartGame()
                        paused = false
                    }, label: {
                        Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90.circle.fill")
                            .foregroundStyle(Color("Base"))
                    })
                    Spacer()
                    // Resume
                    if  pokerEngine.points + pokerEngine.bet > 0 {
                        Button(action: {
                            paused = false
                        }, label: {
                            Image(systemName: "play.circle.fill")
                                .foregroundStyle(Color("TreesLight"))
                        })
                        Spacer()
                    }
                    Spacer()
                }
                .font(.system(size: 80))
            }
            .padding()
            .background(Color("Supplement").opacity(0.4))
        }
    }
}
