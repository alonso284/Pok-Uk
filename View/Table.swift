//
//  Table.swift
//  Pok'Uk
//
//  Created by Alonso Huerta on 17/01/25.
//

import SwiftUI

extension Game {
    var Table: some View {
        VStack(spacing: 0) {
            BettingOptions
            ZStack {
                // Green Background
                RadialGradient(colors: [Color(red: 0.2, green: 0.6, blue: 0.4), .black], center: .center, startRadius: 0, endRadius: 1800)
                HStack {
                    Spacer()
                    Figures()
                    Spacer()
                    // Cards
                    TableCenter
                        .padding(.horizontal)
                    Spacer()
                    Streak
                    Spacer()
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
                .padding(.bottom)
            Spacer()
            RoundedRectangle(cornerRadius:15)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.yellow, .orange, .red]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
                .stroke(Color.white.opacity(0.5), lineWidth: 12)
            Image(systemName: "flame.fill")
                .foregroundStyle(.orange)
                .font(.system(size: 50))
                .padding(.top)
            Spacer()
        }
        .frame(width: 50, height: 500)
    }


    var TableCenter: some View {
//        GeometryReader { geometry in
            VStack {
                // Croupier
                CroupierCards
                Spacer()
                // Buttons and Messages
                MiddleTable
                    .frame(height: 280)
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
            Color(.purple)
                .opacity(0.6)
            HStack {
                // FIXME: Bet size
                Token(description: ("Bet", pokerEngine.bet, false))
                Spacer()
                CircleButton(systemName: "arrow.down", color: .blue)
                    .onTapGesture {
                        pokerEngine.decreaseBet()
                    }
                    .disabled(pokerEngine.roundStarted)
                CircleButton(systemName: "arrow.up", color: .blue)
                    .onTapGesture {
                        pokerEngine.increaseBet()
                    }
                    .disabled(pokerEngine.roundStarted)
                // FIXME: add funcionality (make previous bet
                CircleButton(systemName: "repeat.1.ar", color: .yellow)
//                    CircleButton(systemName: "xmark.circle", color: .orange)
                CircleButton(systemName: "trash", color: .red)
                    .onTapGesture {
                        pokerEngine.resetBet()
                    }
                    .disabled(pokerEngine.roundStarted)
            }
            .padding()
        }
    }
    
    var PlayerVariables: some View {
        // FIXME: Get rid of lower part that is light purple
        ZStack {
            Color(.purple)
                .opacity(0.6)
            HStack {
                Token(description: ("Score", pokerEngine.points, true))
                Spacer()
                // FIXME: Put correct amount and maybe change the dispalued number
                Token(description: ("Peak", pokerEngine.points, true))
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
            if let playerHand = pokerEngine.playerHand, let dealerHand = pokerEngine.dealerHand {
                Group {
                    HandLabel(hand: dealerHand.hand)
//                        .padding()
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.bar.opacity(0.4))
                            .frame(maxWidth: 420, maxHeight: 120)
                        HStack {
                            Text(pokerEngine.buttonMessage)
                                .font(.custom("Mayan", size: 45))
                                .foregroundStyle(.black)
                                .padding(.trailing, 5)
                            CircleButton(systemName: "repeat", color: .blue)
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
                        pokerEngine.startRound()
                    }
                    Spacer()
                    HandLabel(hand: playerHand.hand)
//                        .padding()
                }
                // Draw / Hold Buttons
            } else {
                Spacer()
                Button(action: {
                    pokerEngine.playerTurn()
                    print(pokerEngine.buttonMessage)
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(maxWidth: 420, maxHeight: 120)
//                            .foregroundStyle(Color.orange)
                        VStack {
                            Text(pokerEngine.buttonMessage)
                                .font(.custom("Mayan", size: 40))
                            
                            Text(pokerEngine.bet == 0 ? "Place a bet to play":
                                    (pokerEngine.playerSelected > 0 ? "Change the selected cards": "Keep all current cards"))
                                .font(.custom("Mayan", size: 20))
                            
                        }
                        .foregroundStyle(.black)
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
    Game()
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
