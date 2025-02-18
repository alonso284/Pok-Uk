//
//  SwiftUIView.swift
//  Pok'Uk
//
//  Created by Alonso Huerta on 16/01/25.
//

import SwiftUI

struct CardView: View {
    var showing: Bool = true
    // FIXME: Remove default
    var card: Card = .mask
    var highlight: Bool = false
    
    var body: some View {
        ZStack {
//            RoundedRectangle(cornerRadius: 10)
//                .foregroundStyle(showing ? .white : Color(red: 0.8, green: 0.5, blue: 0.1))
            RadialGradient(colors: [
                (showing ?  .white:
                    Color("Trees")),
                (showing ?  (highlight ?
                                Color("TreesLight"):
                                Color("Supplement")):
                            .gray)
            ],
            center: .center, startRadius: 0, endRadius: 180)
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
                    token
                } else {
                    ZStack {
                        // FIXME
                        ForEach(0..<description.amount, id: \.self) { index in
                            token.offset(x: CGFloat(index * 10))
                        }
                    }
                    Spacer()
                }
            }
        } else {
            token
        }
    }
    
    var token: some View {
        ZStack {
            Circle()
                .fill(.white)
            Circle()
                .fill(Color("Obsidian"))
                .padding(2)
            Image("Token")
                .resizable()
                .scaledToFit()
                .padding(12)
//            Circle()
//                .fill(.black.opacity(0.3))
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
                VStack {
                    Spacer()
                    CircleButton(systemName: "arrow.up", color: Color("Base"), dimension: 50)
                    Spacer()
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
                        Spacer()
                    }
                    CircleButton(systemName: "arrow.down", color: Color("Base"), dimension: 50)
                    Spacer()
                }
            } else {
                HStack {
                    ForEach(Card.allCases) { rank in
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.white)
                            Image(rank.description)
                                .resizable()
                                .scaledToFit()
                                .padding(2)
                        }
                        .frame(width: 55, height: 55)
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
        }
        .frame(width: 350 * multplier, height: 180 * multplier)
    }
}
