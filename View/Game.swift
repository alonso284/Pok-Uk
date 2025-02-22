//
//  SwiftUIView.swift
//  Pok'Uk
//
//  Created by Alonso Huerta on 16/01/25.
//

import SwiftUI
import Combine

struct Game: View {
    @Environment(\.dismiss) var dismiss
    
    // Menus / Sheets
    @State var paused: Bool = false
    @State var rankedCards: Bool = false
    @State var help: Bool = true
    @State var achievements: Bool = false
    
    // Game stats
    let startTime: Date = .now
    @StateObject var pokerEngine = PokerEngine()
    
    // Animation variables
    @State var scaleEffect: CGFloat = 1.0
    @State var isAnimating = false
    @State var errorMessage: String? = nil
    
    let cardShift: CGFloat = 40
    
    var body: some View {
        ZStack {
            Color(.black)
            Color("Supplement").opacity(0.8)
            VStack(spacing: 0) {
                Croupier
                Table
            }
            .ignoresSafeArea()

            // Overlay
//            if paused {
//                ZStack {
//                    Color(white: 0, opacity: 0.5)
//                        .ignoresSafeArea()
//                    PauseMenu
//                        .frame(width: 600, height: 800)
//                }
//            }
            
        }
        .toolbar(content: {
            // Pause
            ToolbarItem(placement: .topBarLeading, content: {
                Button(action: {
                    paused = true
                    SoundManager.instance.playLoop(forResource: "Blink", volume: 0.5)
                }) {
                    CircleButton(systemName: "pause", color: Color("Supplement"))
                }
                .disabled(paused)
            })
            
            // FIXME: Achievements 
            ToolbarItem(placement: .topBarLeading, content: {
                Button(action: {
                    achievements = true
                    SoundManager.instance.playLoop(forResource: "Blink", volume: 0.5)
                    
                }) {
                    CircleButton(systemName: "trophy", color: Color("Supplement"))
                }
                .disabled(paused)
            })
            
            // Hands
            ToolbarItem(placement: .topBarTrailing, content: {
                Button(action: {
                    rankedCards = true
                    SoundManager.instance.playLoop(forResource: "Blink", volume: 0.5)
                }) {
                    CircleButton(systemName: "info", color: Color("Supplement"))
                }
                .disabled(paused)
            })
            
            // Help
            ToolbarItem(placement: .topBarTrailing, content: {
                Button(action: {
                    help = true
                    SoundManager.instance.playLoop(forResource: "Blink", volume: 0.5)
                }) {
                    CircleButton(systemName: "questionmark", color: Color("Supplement"))
                }
                .disabled(paused)
            })
        })
        .sheet(isPresented: $paused) {
            PauseMenu
        }
        .sheet(isPresented: Binding(
            get: { pokerEngine.points + pokerEngine.bet <= 0 },
            set: { _ in }
        )) {
            PauseMenu
                .interactiveDismissDisabled()
        }
        .sheet(isPresented: $rankedCards) {
            RankedCards(opened: $rankedCards)
        }
        .sheet(isPresented: $help) {
            HelpMenu(opened: $help)
        }
        .sheet(isPresented: $achievements) {
            Achievements
        }
        
    }
    

}

#Preview {
    NavigationStack {
        Game()
    }
}
