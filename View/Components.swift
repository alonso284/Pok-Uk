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
    
    var body: some View {
        ZStack {
//            RoundedRectangle(cornerRadius: 10)
//                .foregroundStyle(showing ? .white : Color(red: 0.8, green: 0.5, blue: 0.1))
            RadialGradient(colors: [(showing ? .white: .teal), (showing ? Color(red: 0.8, green: 0.5, blue: 0.1): .gray)], center: .center, startRadius: 0, endRadius: 180)
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
                    .frame(maxWidth: 80, maxHeight: 80)
            }
        }
        .frame(width: 100, height: 140)
    }
}

struct CircleButton: View {
    var systemName: String
    var color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(color)
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .padding(12)
        }
        .frame(width: 50, height: 50)
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
                        .font(.system(size: 35))
                }
                Text(String(description.amount))
                    .foregroundStyle(.white)
                    .font(.system(size: 35))
                    .frame(width: 60)
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
                .foregroundColor(.white)
            
            Circle()
                .foregroundColor(.purple)
                .padding(3)
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
            .font(.largeTitle)
    }
}
