//
//  HelpCard.swift
//  Pok’Uk
//
//  Created by Alonso Huerta on 10/02/25.
//
import SwiftUI

struct RankedCards: View {
    let hands: [(name: String, cards: [(highlight: Bool, card: Card)])] = [
        ("High Card", [
            (true, .sun),
            (false, .eagle),
            (false, .fish),
            (false, .pelican),
            (false, .turtle)
        ]),
        ("Pair", [
            (true, .fish),
            (true, .fish),
            (false, .pelican),
            (false, .mask),
            (false, .eagle)
        ]),
        ("Two Pair", [
            (true, .mask),
            (true, .mask),
            (true, .pelican),
            (true, .pelican),
            (false, .sun)
        ]),
        ("Three of a Kind", [
            (true, .eagle),
            (true, .eagle),
            (true, .eagle),
            (false, .sun),
            (false, .mask)
        ]),
        ("Full House", [
            (true, .sun),
            (true, .sun),
            (true, .sun),
            (true, .fish),
            (true, .fish)
        ]),
        ("Four of a Kind", [
            (true, .pelican),
            (true, .pelican),
            (true, .pelican),
            (true, .pelican),
            (false, .fish)
        ]),
        ("Five of a Kind", [
            (true, .turtle),
            (true, .turtle),
            (true, .turtle),
            (true, .turtle),
            (true, .turtle)
        ])
    ]
    
    @Binding var opened: Bool
    
    var body: some View {
        ZStack {
            Color.white
            Color("Supplement").opacity(0.8)
            ScrollView {
                Text("Ranked Hands")
                    .font(.custom("Mayan", size: 60))
                    .foregroundStyle(.white)
                    .padding(.top, 10)
                    .padding(.vertical, 50)
                    .frame(maxWidth: .infinity)
                    .background(Color("Supplement").opacity(0.4))
                    .padding(.bottom, 20)

                ForEach(hands, id: \ .name) { hand in
                    VStack {
                        Text(hand.name)
                            .font(.custom("Mayan", size: 40))
                            .foregroundStyle(.white)
                            .offset(y: 6)
                        HStack {
                            ForEach(hand.cards, id: \ .card) { card in
                                CardView(card: card.card, highlight: card.highlight)
                                    .padding((card.highlight ? .bottom: .top), 25)
                            }
                        }
                    }
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)
                    Divider()
                        .frame(height: 4)
                        .background(Color.black.opacity(0.2))
                        .padding()
                    
                }
                
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
            .padding(.bottom, 60)
        }
    }
}

#Preview {
    RankedCards(opened: .constant(true))
}
