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
                if pokerEngine.points + pokerEngine.bet <= 0 {
                Text("Out of Tokens")
                        .font(.custom("Mayan", size: 80))
                        .foregroundStyle(.white)
                        .padding(.top, 10)
                        .padding(.vertical, 25)
                        .frame(maxWidth: .infinity)
                        .background(Color("Accent").opacity(0.4))
                } else {
                    HStack {
                        Image("Icon")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .cornerRadius(20)
                            .padding(.trailing, 10)
                        
                        Text("Pok'Uk")
                            .font(.custom("Mayan", size: 80))
                            .foregroundStyle(.white)
                            .padding(.top, 10)
                    }
                    .padding(.vertical, 25)
                    .frame(maxWidth: .infinity)
                    .background(Color("Supplement").opacity(0.4))
                }
                Spacer()
                Stats
                Spacer()
                OptionButtons
            }
            
        }
        .foregroundStyle(.white)
    }
    
    var Stats: some View {
        VStack(alignment: .trailing) {
            HStack {
                Text("Hands: "); Spacer(); Text("\(pokerEngine.handsPlayed)")
            }
            .font(.custom("Mayan", size: 40))
            
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
            .padding(.vertical, 1)
            
            HStack {
                let timeSpent = Int(-startTime.timeIntervalSinceNow)
                let hours = timeSpent / 3600
                let minutes = (timeSpent % 3600) / 60
                let seconds = timeSpent % 60
                
                Text("Time: ")
                Spacer()
                Text(String(format: "%02d:%02d:%02d", hours, minutes, seconds))
            }
            .font(.custom("Mayan", size: 30))
        }
        .frame(width: 350)
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
            .padding(.vertical, 30)
            .background(Color("Supplement").opacity(0.4))
        }
    }
}
