//
//  SwiftUIView.swift
//  Pok'Uk
//
//  Created by Alonso Huerta on 16/01/25.
//

import SwiftUI

// FIXME Dimensions
// FIXME The right person is not winning
// FIXME What does this address??

struct Game: View {
    @Binding var playing: Bool
    @State var paused: Bool = false
    @State var help: Bool = false
    
    // Game stats
    @State var time:    Int = 0
    @StateObject var pokerEngine = PokerEngine()
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        ZStack {
            Color(.black)
            VStack(spacing: 0) {
                Croupier
                Table
            }
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        paused.toggle()
                    }) {
                        CircleButton(systemName: "pause", color: .orange)
                    }
                    .disabled(paused)
                    Spacer()
                    Button(action: {
                        // FIXME
                    }) {
                        CircleButton(systemName: "arkit", color: .red)
                    }
                    .disabled(paused)
                    Button(action: {
                        help.toggle()
                    }) {
                        CircleButton(systemName: "menucard", color: .orange)
                    }
                    .disabled(paused)
                    
                }
                .padding(.horizontal)
                Spacer()
            }

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
//        .toolbar(content: {
//            // Pause
//            ToolbarItem(placement: .topBarLeading, content: {
//                Button(action: {
//                    paused.toggle()
//                }) {
//                    CircleButton(systemName: "pause", color: .orange)
//                }
//                .disabled(paused)
//            })
//            
//            // AR
//            ToolbarItem(placement: .topBarTrailing, content: {
//                Button(action: {
//                    // FIXME
//                }) {
//                    CircleButton(systemName: "arkit", color: .red)
//                }
//                .disabled(paused)
//            })
//            
//            // Help
//            ToolbarItem(placement: .topBarTrailing, content: {
//                Button(action: {
//                    help.toggle()
//                }) {
//                    CircleButton(systemName: "menucard", color: .orange)
//                }
//                .disabled(paused)
//            })
//        })
        .sheet(isPresented: $paused) {
            PauseMenu
                .interactiveDismissDisabled()
        }
        .sheet(isPresented: $help) {
            HelpMenu()
        }
        
    }
    

}

#Preview {
    NavigationStack {
        Game(playing: .constant(true))
    }
}
