//
//  HelpCard.swift
//  Pok’Uk
//
//  Created by Alonso Huerta on 10/02/25.
//
import SwiftUI

struct HelpMenu: View {
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
    
    var body: some View {
        ZStack {
            Color("Supplement").opacity(0.8)
            ScrollView {
                Text("Ranked Hands")
                    .font(.custom("Mayan", size: 60))
                    .foregroundStyle(.white)
                    .padding(.bottom, 40)
                
                ForEach(hands, id: \ .name) { hand in
                    VStack {
                        Text(hand.name)
                            .font(.custom("Mayan", size: 40))
                            .foregroundStyle(.white)
                        HStack {
                            ForEach(hand.cards, id: \ .card) { card in
                                CardView(card: card.card, highlight: card.highlight)
                                
                            }
                        }
                    }
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)
                }
            }
            .padding(.vertical, 60)
        }
    }
}

#Preview {
    HelpMenu()
}
