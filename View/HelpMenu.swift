//
//  HelpCard.swift
//  Pok’Uk
//
//  Created by Alonso Huerta on 10/02/25.
//

import SwiftUI

struct HelpMenu: View {
    var body: some View {
        ZStack {
            Color.blue.opacity(0.2)
            ScrollView {
                Text("Figure Ranking")
                
                Figures(style: .horizontal)
                VStack {
                    Text("High Card")
                    HStack {
                        CardView(card: .sun, highlight: true)
                        CardView(card: .eagle)
                        CardView(card: .fish)
                        CardView(card: .pelican)
                        CardView(card: .turtle)
                    }
                }
                
                VStack {
                    Text("Pair")
                    HStack {
                        CardView(card: .fish, highlight: true)
                        CardView(card: .fish, highlight: true)
                        CardView(card: .pelican)
                        CardView(card: .mask)
                        CardView(card: .eagle)
                    }
                }
                
                VStack {
                    Text("Two Pair")
                    HStack {
                        CardView(card: .mask, highlight: true)
                        CardView(card: .mask, highlight: true)
                        CardView(card: .pelican, highlight: true)
                        CardView(card: .pelican, highlight: true)
                        CardView(card: .sun)
                    }
                }
                
                VStack {
                    Text("Three of a Kind")
                    HStack {
                        CardView(card: .eagle, highlight: true)
                        CardView(card: .eagle, highlight: true)
                        CardView(card: .eagle, highlight: true)
                        CardView(card: .sun)
                        CardView(card: .mask)
                    }
                }
                
                VStack {
                    Text("Full House")
                    HStack {
                        CardView(card: .sun, highlight: true)
                        CardView(card: .sun, highlight: true)
                        CardView(card: .sun, highlight: true)
                        CardView(card: .fish, highlight: true)
                        CardView(card: .fish, highlight: true)
                    }
                }
                
                VStack {
                    Text("Four of a Kind")
                    HStack {
                        CardView(card: .pelican, highlight: true)
                        CardView(card: .pelican, highlight: true)
                        CardView(card: .pelican, highlight: true)
                        CardView(card: .pelican, highlight: true)
                        CardView(card: .fish)
                    }
                }
                
                VStack {
                    Text("Five of a Kind")
                    HStack {
                        CardView(card: .turtle, highlight: true)
                        CardView(card: .turtle, highlight: true)
                        CardView(card: .turtle, highlight: true)
                        CardView(card: .turtle, highlight: true)
                        CardView(card: .turtle, highlight: true)
                    }
                }
            }
            .padding(60)
        }
    }
}

#Preview {
    HelpMenu()
}
