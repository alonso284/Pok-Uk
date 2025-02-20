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
                Text("Pok'Uk")
                    .font(.custom("Mayan", size: 90))
                    .foregroundStyle(.white)
                    .padding(.top, 10)
                    .padding(.vertical, 25)
                    .frame(maxWidth: .infinity)
                    .background(Color("Supplement").opacity(0.4))
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
        VStack {
            HStack {
                Text("Total Hands: "); Spacer(); Text("\(pokerEngine.handsPlayed)")
            }
            .font(.custom("Mayan", size: 60))
            .frame(width: 350)
            .padding()
            Group {
                HStack {
                    Text("Won: "); Spacer(); Text("\(pokerEngine.won)")
                }
                HStack {
                    Text("Lost: "); Spacer(); Text("\(pokerEngine.lost)")
                }
                HStack {
                    Text("Drawn: "); Spacer(); Text("\(pokerEngine.drawn)")
                }
            }
            .font(.custom("Mayan", size: 40))
            .frame(width: 300)
            .padding(1)
        }
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
//                        restart()
                    }, label: {
                        Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90.circle.fill")
                            .foregroundStyle(Color("Base"))
                    })
                    Spacer()
                    // Resume
                    Button(action: {
//                        resume()
                        paused = false
                    }, label: {
                        Image(systemName: "play.circle.fill")
                            .foregroundStyle(Color("TreesLight"))
                    })
                    Spacer()
                    Spacer()
                }
                .font(.system(size: 80))
            }
            .padding()
            .background(Color("Supplement").opacity(0.4))
        }
    }
}
