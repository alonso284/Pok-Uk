//
//  SwiftUIView.swift
//  Pok'Uk
//
//  Created by Alonso Huerta on 16/01/25.
//

import SwiftUI

struct CardView: View {
    var showing: Bool = true
    var card: Card
    var highlight: Bool = false
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [
                (showing ?  .white:
                    Color("Trees")),
                (showing ?  (highlight ?
                                Color("TreesLight"):
                                Color("Supplement")):
                            .gray)
            ],
            center: .center, startRadius: 0, endRadius: 100)
                .ignoresSafeArea()
                .clipShape(RoundedRectangle(cornerRadius: 10))
            if !showing {
                Image("Calendar")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.5)
                    .padding(5)
            } else {
                Image(card.description)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 64, maxHeight: 64)
            }
        }
        .frame(width: 80, height: 112)
    }
}

struct CircleButton: View {
    var systemName: String
    var color: Color
    var dimension: CGFloat = 50
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(color)
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .padding(dimension/4)
        }
        .frame(width: dimension, height: dimension)
    }
}

struct Token: View {
    var description: (text: String?, amount: UInt, number: Bool)?
    
    var body: some View {
        if let description {
            HStack {
                if let text = description.text {
                    Text("\(text):")
                        .foregroundStyle(.white)
                        .font(.custom("Mayan", size: 40))
                }
                Text(String(description.amount))
                    .foregroundStyle(.white)
                    .frame(width: 60)
                    .font(.custom("Mayan", size: 40))
                if description.number {
                    token()
                } else {
                    ZStack {
                        // FIXME: Magnitud
                        ForEach(0..<description.amount, id: \.self) { index in
                            token().offset(x: CGFloat(index * 10))
                        }
                        
                    }
                    Spacer()
                }
            }
        } else {
            token()
        }
    }
    
    func token(magnitud: UInt = 0) -> some View {
        ZStack {
            Circle()
                .fill(.white)
            Circle()
                .fill(Color("Obsidian\(magnitud)"))
                .padding(2)
            Image("Token")
                .resizable()
                .scaledToFit()
                .padding(12)
        }
        .frame(width: 50, height: 50)
    }
}

struct HandLabel: View {
    var hand: PokerHand
    var body: some View {
        Text(hand.description)
            .font(.custom("Mayan", size: 40))
    }
}

struct Figures: View {
    enum Style {
        case vertical, horizontal
    }
    
    var style: Style = .vertical
    
    var body: some View {
        Group {
            if style == .vertical {
                // Show that these are ranked cards
                VStack {
                    ForEach(Card.allCases) { rank in
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("Base").opacity(0.2))
                            Image(rank.description)
                                .resizable()
                                .scaledToFit()
                                .padding(2)
                        }
                        .frame(width: 55, height: 55)
                        .padding(.vertical, 5)
                    }
                }
            } else {
                HStack {
                    ForEach(Card.allCases) { rank in
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("Base").opacity(0.2))
                            Image(rank.description)
                                .resizable()
                                .scaledToFit()
                                .padding(2)
                        }
                        .frame(width: 45, height: 45)
                        .padding(.horizontal, 2)
                    }
                }
            }
        }
    }
}

struct TextBox: View {
    var text: String
    var color: Color = .white
    var multplier: CGFloat = 1
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black.opacity(0.2), lineWidth: 5)
                .fill(color)
            
            Text(text)
                .font(.custom("Mayan", size: 30))
                .foregroundStyle(.black)
                .padding()
        }
        .frame(width: 350 * multplier, height: 180 * multplier)
    }
}

struct CustomTextBox: View {
    var text: String
    
    var height: CGFloat = 240
    var width: CGFloat = 520
    var textSize: CGFloat = 120
    
    var backgroundColor: Color = Color("Base")
    var strokeColor: Color = Color("Trees")
    var strokeSize: CGFloat = 15
    
    var body: some View {
        ZStack {
            
            Image("Base")
                .resizable()
                .frame(width: width, height: height)
                .clipped()
            
            RoundedRectangle(cornerRadius: strokeSize)
                .stroke(strokeColor, lineWidth: strokeSize)
                .fill(backgroundColor.opacity(0.3))
            
            Text(text)
                .font(.custom("Mayan", size: textSize))
                .foregroundStyle(.black)
                .padding(.top, 0.15 * height)
        }
        .frame(width: width, height: height)
    }
}

#Preview {
    TextBox(text: "Pok'Uk", color: Color("Base"), multplier: 1.2)
}
