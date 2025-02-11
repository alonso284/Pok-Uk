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
            Color.cyan
            
            VStack {
                Spacer()
                Text("FIXME: add image")
                Spacer()
                Stats
                Spacer()
                OptionButtons
                Spacer()
            }
        }
    }
    
    var Stats: some View {
        VStack {
            HStack {
                Text("Score: "); Spacer(); Text("\(pokerEngine.points)")
            }
            .font(.largeTitle)
            .frame(width: 350)
            .padding()
            Group {
                HStack {
                    Text("Score: "); Spacer(); Text("\(pokerEngine.points)")
                }
                HStack {
                    Text("Score: "); Spacer(); Text("\(pokerEngine.points)")
                }
                HStack {
                    Text("Score: "); Spacer(); Text("\(pokerEngine.points)")
                }
            }
            .font(.title)
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
                        self.help = false
                        self.paused = false
                        self.playing = false
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.red)
                    })
                    Spacer()
                    // Restart
                    Button(action: {
//                        restart()
                    }, label: {
                        Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90.circle.fill")
                            .foregroundStyle(.yellow)
                    })
                    Spacer()
                    // Resume
                    Button(action: {
//                        resume()
                    }, label: {
                        Image(systemName: "play.circle.fill")
                            .foregroundStyle(.green)
                    })
                    Spacer()
                    Spacer()
                }
                .font(.system(size: 80))
            }
            .foregroundStyle(.indigo)
            .padding()
            .background(Color(.blue))
        }
    }
}
