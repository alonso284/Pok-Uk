//
//  Croupier.swift
//  Pok'Uk
//
//  Created by Alonso Huerta on 17/01/25.
//

import SwiftUI

extension Game {
    var Croupier: some View {
        VStack(spacing: 0) {
            ZStack {
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                VStack {
                    Spacer()
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                    
                }
            }
        }
    }
    
    var image: String {
        switch pokerEngine.endGameState {
        case .win:
            return "win"
        case .lose:
            return "lose"
        case .draw:
            return "thinking"
        case .none:
            return "idle"
        }
    }
}
