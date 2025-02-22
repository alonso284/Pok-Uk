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
            ScrollView {
                Text("How To Play")
                    .font(.custom("Mayan", size: 60))
                    .padding(.top, 10)
                    .padding(.vertical, 50)
                    .frame(maxWidth: .infinity)
                    .background(Color("Supplement").opacity(0.4))
                
                VStack(alignment: .leading) {
                    

                    VStack(alignment: .center) {
                        Image("Icon")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .padding()
                            .cornerRadius(80)
                        Text("Play Picture Poker with Halak, your friendly Mayan priest! Scroll down for instructions on how to play.")
                    }
                    
                    
                    Divider()
                        .frame(height: 4)
                        .background(Color.black.opacity(0.2))
                        .padding()
                    
                    Text("1. Bet your Obsidian tokens against Halak.")
                    
                    HStack {
                        Spacer()
                        Token()
                        Image(systemName: "forward.frame")
                            .padding(.horizontal)
                        CircleButton(systemName: "minus", color: Color("TreesLight"))
                        CircleButton(systemName: "plus", color: Color("TreesLight"))
                        CircleButton(systemName: "square.and.arrow.up", color: Color("Base"))
                        CircleButton(systemName: "trash", color: Color("Accent"))
                        Spacer()
                    }
                    .padding(.vertical)
                    
                    Divider()
                        .frame(height: 4)
                        .background(Color.black.opacity(0.2))
                        .padding()
                    
                    Text("2. Hold or draw cards to beat him.")
                    
                    HStack {
                        Spacer()
                        CardView(card: .eagle)
                        CardView(card: .turtle)
                        CardView(card: .fish)
                            .padding(.bottom, 50)
                        CardView(card: .sun)
                            .padding(.bottom, 50)
                        CardView(card: .pelican)
                        Spacer()
                    }
                    .padding(.vertical)
                    
                    Divider()
                        .frame(height: 4)
                        .background(Color.black.opacity(0.2))
                        .padding()
                    
                    Text("3. Check the ranked cards to see how your hand stacks up.")
                    
                    HStack {
                        Spacer()
                        CircleButton(systemName: "folder", color: Color("Supplement"))
                            .padding(.trailing, 4)
                        Figures(style: .horizontal)
                        Spacer()
                    }
                    .padding()
                    
                    Divider()
                        .frame(height: 4)
                        .background(Color.black.opacity(0.2))
                        .padding()
                    
                    Text("4. Win, and you’ll double your bet. Lose, and Halak keeps your tokens.")

                    HStack {
                        Spacer()
                        Token(description: (text: nil, amount: 10, number: true))
                        Image(systemName: "plusminus")
                        Spacer()
                    }
                    .padding(.vertical)
                    
                    
                    Divider()
                        .frame(height: 4)
                        .background(Color.black.opacity(0.2))
                        .padding()
                    
                    Text("5. Get more points to unlock new levels and achievements!")
                    
                    HStack {
                        Spacer()
                        CircleButton(systemName: "trophy", color: Color("Supplement"))
                        Spacer()
                    }
                    .padding(.vertical)
                    
                    Divider()
                        .frame(height: 4)
                        .background(Color.black.opacity(0.2))
                        .padding()
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            opened.toggle()
                        }, label: {
                            CustomTextBox(text: "Close", height: 60, width: 120, textSize: 30, strokeSize: 5)
                        })
                        Spacer()
                    }
                    
                    
                }
                .padding(.horizontal, 50)
                .padding(.bottom, 40)
                    
            }
            .font(.custom("Mayan", size: 30))
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    HelpMenu(opened: .constant(true))
}
