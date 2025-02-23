//
//  SwiftUIView.swift
//  Pok’Uk
//
//  Created by Alonso Huerta on 19/02/25.
//

import SwiftUI

struct HelpMenu: View {
    @Binding var opened: Bool
    
    var body: some View {
        ZStack {
            Color.white
            Color("Supplement").opacity(0.8)
            TabView {
                
                VStack(alignment: .center) {
                    Text("How To Play")
                        .font(.custom("Mayan", size: 60))
                        .padding(.top, 10)
                        .padding(.vertical, 50)
                        .frame(maxWidth: .infinity)
                        .background(Color("Supplement").opacity(0.4))
                    Image("Icon")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .padding()
                        .cornerRadius(80)
                    
                    VStack(alignment: .leading) {
                        Text("Play Picture Poker against Halak, your friendly Mayan priest!")
                        Text(""); Text("")
                        Text("Continue for more instructions.")
                    }
                    .padding()
                    Spacer()
                }
                
//                VStack(alignment: .leading) {
//                    Spacer()
//                    Text("Objective:")
//                        .font(.custom("Mayan", size: 30))
//                        .padding(.bottom, 5)
//                    Text("Get the best hand of matching pictures to win tokens.")
//                        .font(.custom("Mayan", size: 20))
//                    Spacer()
//                    Text("You start with 5 cards, each showing a picture. Each picture has a different value.")
//                    Spacer()
//                }
//                .frame(height: 250)
//                .padding()
//                .background(Color("Supplement").opacity(0.4))

                
                VStack(alignment: .center) {
                    Spacer()
                    Text("1. You start with 5 cards, each showing a picture. Your objective is to beat Halak's hand.")
                        .padding(.horizontal, 20)
                    Spacer()
                    HStack {
                        Spacer()
                        CardView(card: .eagle)
                        CardView(card: .turtle)
                        CardView(card: .fish)
                        CardView(card: .sun)
                        CardView(card: .pelican)
                        Spacer()
                    }
                    .padding(.vertical)
                    Spacer()
                }
                .frame(height: 400)
                .padding()
                .background(Color("Supplement").opacity(0.4))
                
                
                VStack(alignment: .center) {
                    Spacer()
                    Text("2. Choose which cards to hold (keep) and which to draw (replace). You only have one chance!")
                        .padding(.horizontal, 20)
                    HStack(spacing: 0) {
                        Spacer()
                        HStack {
                            CardView(card: .eagle)
                            CardView(card: .turtle)
                            CardView(card: .fish)
                                .padding(.bottom, 50)
                            CardView(card: .sun)
                                .padding(.bottom, 50)
                            CardView(card: .pelican)
                        }
                        .scaleEffect(0.65)
                        .offset(x: 60)
                        Image(systemName: "arrow.right")
                        HStack {
                            CardView(card: .eagle)
                            CardView(card: .turtle)
                            CardView(card: .turtle)
                            CardView(card: .eagle)
                            CardView(card: .pelican)
                        }
                        .scaleEffect(0.65)
                        .offset(x: -60)
                        Spacer()
                    }
                    .scaleEffect(0.8)
                    Spacer()
                }
                .frame(height: 400)
                .padding()
                .background(Color("Supplement").opacity(0.4))
                
                
                
                VStack(alignment: .center) {
                    Spacer()
                    Text("3. Bet your Obsidian tokens. Win to double your bet. Lose, and Halak keeps your tokens.")
                        .padding(.horizontal, 20)
                    Spacer()
                    HStack {
                        Spacer()
                        Token()
                        Image(systemName: "forward.frame")
                            .padding(.horizontal)
                        CircleButton(systemName: "minus", color: Color("TreesLight"))
                        CircleButton(systemName: "plus", color: Color("TreesLight"))
                        CircleButton(systemName: "infinity", color: Color("Base"))
                        CircleButton(systemName: "trash", color: Color("Accent"))
                        Spacer()
                    }
                    .padding(.vertical)
                    Spacer()
                }
                .frame(height: 400)
                .padding()
                .background(Color("Supplement").opacity(0.4))
//                
//                VStack(alignment: .center) {
//                    Spacer()
//                    Text("4. Compare your final hand to the ranked card combinations to determine if you’ve won.")
//                        .padding(.horizontal, 20)
//                    Spacer()
//                    HStack {
//                        Spacer()
//                        CardView(card: .eagle, highlight: true)
//                            .padding(.bottom, 50)
//                        CardView(card: .turtle, highlight: true)
//                            .padding(.bottom, 50)
//                        CardView(card: .turtle, highlight: true)
//                            .padding(.bottom, 50)
//                        CardView(card: .eagle, highlight: true)
//                            .padding(.bottom, 50)
//                        CardView(card: .pelican)
//                        Spacer()
//                    }
//                    .padding(.vertical)
//                    Spacer()
//                }
//                .frame(height: 400)
//                .padding()
//                .background(Color("Supplement").opacity(0.4))
                
               
                VStack(alignment: .center) {
                    Spacer()
                    Text("4. Complete achievements, consult ranked hands and get instructions on how to play.")
                        .padding(.horizontal, 20)
                    Spacer()
                    HStack(spacing: 20) {
                        CircleButton(systemName: "trophy", color: Color("Supplement"))
                        CircleButton(systemName: "info", color: Color("Supplement"))
                        CircleButton(systemName: "questionmark", color: Color("Supplement"))
                    }
                    .padding(.vertical)
                    Button(action: {
                        opened = false
                        SoundManager.instance.playLoop(forResource: "Blink", volume: 0.5)
                    }, label: {
                        CustomTextBox(text: "Close", height: 60, width: 120, textSize: 30, strokeSize: 5)
                    })
                    Spacer()
                }
                .frame(height: 400)
                .padding()
                .background(Color("Supplement").opacity(0.4))
                
                
                
//                VStack(alignment: .center) {
//                    Spacer()
//                    Text("5. Collect more tokens, unlock new levels and earn achievements!")
//                        .padding(.horizontal, 20)
//                    Spacer()
//                    HStack(spacing: 15) {
//                        Spacer()
//                        CircleButton(systemName: "trophy", color: Color("Supplement"))
//                        
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 10)
//                                .stroke(Color.black.opacity(0.5), lineWidth: 5)
//                                .fill(Color("Trees"))
//                                .frame(width: 100, height: 60)
//                            HStack {
//                                Token(description: (text: nil, amount: 25, number: true))
//                                    .scaleEffect(0.5)
//                            }
//                        }
//                        Spacer()
//                        Token(description: (text: nil, amount: 10, number: true))
//                        Image(systemName: "plusminus")
//                        Spacer()
//                    }
//                    .padding(.vertical)
//                    Spacer()
//                }
//                .frame(height: 400)
//                .padding()
//                .background(Color("Supplement").opacity(0.4))
            }
            .tabViewStyle(PageTabViewStyle())
            .font(.custom("Mayan", size: 30))
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    HelpMenu(opened: .constant(true))
}
