//
//  Table.swift
//  Pok'Uk
//
//  Created by Alonso Huerta on 17/01/25.
//

import SwiftUI

extension Game {
    var Table: some View {
        VStack(spacing: 5) {
            BettingOptions
            ZStack {
                // Green Background
                Color.white
                RadialGradient(colors: [Color("Supplement"), .black], center: .center, startRadius: 200, endRadius: 1800)
                    .opacity(0.85)
//                Image("Base")
//                    .resizable()
//                    .scaledToFill()
//                Color("Base").opacity(0.8)
                
                HStack {
                    Spacer()
                    Figures()
                    Spacer()
                    // Cards
                    TableCenter
                        .padding()
                    Spacer()
//                    Streak
//                    Spacer()
                }
                .padding()
            }
            PlayerVariables
        }
    }
    
    
    var Streak: some View {
        VStack {
            Spacer()
            // FIXME: put real number
            Text("90")
                .font(.custom("Mayan", size: 40))
                .foregroundStyle(.white)
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius:15)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.yellow, .orange, .red]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
                    .stroke(Color.white.opacity(0.8), lineWidth: 5)
                RoundedRectangle(cornerRadius:15)
                    .fill(
                        Color("Base").opacity(0.6)
                    )
                
            }
            .padding(.vertical)
            CircleButton(systemName: "flame", color: Color("Base"), dimension: 50)
            Spacer()
        }
        .frame(width: 50)
    }


    var TableCenter: some View {
//        GeometryReader { geometry in
            VStack {
                // Croupier
                CroupierCards
                Spacer()
                // Buttons and Messages
                MiddleTable
                    .frame(height: 200)
                Spacer()
                PlayerCards
                // Player
                
            }
//        }
//        .background(.red)
//        SpriteView(scene: makeGameScene())
//            .frame(width: 300, height: 400) // Define the size of the SpriteKit view
//            .cornerRadius(15)
//            .shadow(radius: 10)
    }
    
    var BettingOptions: some View {
        ZStack {
            Color("Supplement")
//                .opacity(0.6)
            HStack {
                // FIXME: Bet size
                Token(description: ("Wager", pokerEngine.bet, false))
                Spacer()
                
                // Decrease

                Button(action: {
                    pokerEngine.decreaseBet()
                    SoundManager.instance.playLoop(forResource: "Coin", volume: 1)
                }, label: {CircleButton(systemName: "arrow.down", color: Color("TreesLight"))})
                    .disabled(pokerEngine.roundStarted || pokerEngine.bet <= 0)
                // Increase
                Button(action: {
                    pokerEngine.increaseBet()
                }, label: {CircleButton(systemName: "arrow.up", color: Color("TreesLight"))})
                .disabled(pokerEngine.roundStarted || pokerEngine.points == 0 || pokerEngine.bet >= pokerEngine.maxBet)
                // Repeat
                Button(action: {
                    pokerEngine.repeatBet()
                    
                }, label: {CircleButton(systemName: "repeat", color: Color("Base"))})
                    .disabled(pokerEngine.roundStarted || pokerEngine.points + pokerEngine.bet < pokerEngine.previousBet)
                
                // Reset
                Button(action: {
                    pokerEngine.resetBet()
                    
                }, label: {CircleButton(systemName: "trash", color: Color("Accent"))})
                    .disabled(pokerEngine.roundStarted)
            }
            .padding()
        }
    }
    
    var PlayerVariables: some View {
        // FIXME: Get rid of lower part that is light purple
        ZStack {
            Color("Supplement")
                .opacity(0.8)
            HStack {
                Token(description: ("Tokens", pokerEngine.points, true))
                Spacer()
                // FIXME: Put correct amount and maybe change the dispalued number
//                Token(description: ("Peak", pokerEngine.points, true))
                Text("v1.3.0")
                    .font(.custom("Mayan", size: 30))
                    .foregroundStyle(.white)
            }
            .padding(.bottom)
            .padding()
        }
    }
    
    var PlayerCards: some View {
        HStack {
            ForEach(pokerEngine.playerCards.indices, id: \.self) { index in
                let card = pokerEngine.playerCards[index].0
                let isSelected = pokerEngine.playerCards[index].1
                
                if let playerHand = pokerEngine.playerHand {
                    CardView(showing: true, card: card, highlight: playerHand.cards.contains(card))
                        .offset(y: (playerHand.cards.contains(card) ? -cardShift : 0))
//                        .opacity(playerHand.cards.contains(card) ? (isVisible ? 1 : 0): 1)
                } else {
                    //                    FIXME: This doesnt look very nice
                    
                    CardView(showing: true, card: card)
                        .offset(y: (isSelected ? -cardShift : 0))
                        .animation(.easeInOut(duration: 0.2), value: isSelected)
                        .onTapGesture {
                            SoundManager.instance.playLoop(forResource: "Card", volume: 0.7)
                            pokerEngine.playerCards[index].1.toggle()
                        }
                }
            }
        }
        .padding(.top, cardShift)
    }
    
    var CroupierCards: some View {
        HStack {
            if let dealerHand = pokerEngine.dealerHand {
                ForEach(pokerEngine.dealerCards, id: \.self.0){
                    (card, selected) in
                    
                    CardView(showing: true, card: card, highlight: dealerHand.cards.contains(card))
                        .offset(y: (dealerHand.cards.contains(card) ? cardShift : 0))
                    }
            } else {
                ForEach(pokerEngine.dealerCards, id: \.self.0){
                    (card, selected) in
                    CardView(showing: false, card: card)
                        .offset(y: (selected ? cardShift : 0))
                }
            }
        }
        .padding(.bottom, cardShift)
    }
    
    var MiddleTable: some View {
        VStack {
            // Final Result
            if pokerEngine.endGameState != nil {
                Group {
//                    HandLabel(hand: dealerHand.hand)
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("Base").opacity(0.3))
                            .stroke(Color.black.opacity(0.2), lineWidth: 4)
                            .frame(maxWidth: 420, maxHeight: 120)
                        HStack {
                            Text(pokerEngine.buttonMessage)
                                .font(.custom("Mayan", size: 45))
                                .foregroundStyle(.white)
                                .padding(.trailing, 5)
                            CircleButton(systemName: "repeat", color: Color("Trees"))
                        }
                        
                    }
                    .onAppear {
                        startTimer()
                    }
                    .onDisappear {
                        stopTimer()
                    }
                    .opacity(isVisible ? 1 : 0.00001)
                    .onTapGesture {
                        pokerEngine.endRound()
                        
                    }
                    Spacer()
//                    HandLabel(hand: playerHand.hand)
                }
                // Draw & Hold Buttons
            } else {
                Spacer()
                Button(action: {
                    pokerEngine.playerTurn()
                    print(pokerEngine.buttonMessage)
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black.opacity(0.2), lineWidth: 5)
                            .fill(Color("Base").opacity(pokerEngine.bet == 0 ? 0.1 : 0.3))
                            .frame(maxWidth: 420, maxHeight: 120)
                            
                        VStack {
                            Text(pokerEngine.buttonMessage)
                                .font(.custom("Mayan", size: 40))
                                .foregroundStyle(.white)
                            
//                            Text(pokerEngine.bet == 0 ? "Place a bet to play":
//                                    (pokerEngine.playerSelected > 0 ? "Change the selected cards": "Keep all current cards"))
//                                .font(.custom("Mayan", size: 20))
                            
                        }
                        .foregroundStyle(.white)
                    }
                })
                .disabled(pokerEngine.bet == 0)
                Spacer()
            }
        }
        .padding()

    }
    
    private func startTimer() {
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                isVisible.toggle()
            }
    }

    /// Stops the timer to prevent memory leaks
    private func stopTimer() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }
    
//    func makeGameScene() -> SKScene {
//        let scene = GameScene(size: CGSize(width: 300, height: 400))
//        scene.scaleMode = .aspectFill
//        return scene
//    }
}



#Preview {
    NavigationStack {
        Game()
    }
}


//class GameScene: SKScene {
//    override func didMove(to view: SKView) {
//        self.backgroundColor = .blue
//
//        let label = SKLabelNode(text: "Hello, SpriteKit in SwiftUI!")
//        label.fontSize = 24
//        label.fontColor = .white
//        label.position = CGPoint(x: size.width / 2, y: size.height / 2)
//        addChild(label)
//    }
//}
