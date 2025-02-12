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
            ZStack {
                RadialGradient(colors: [Color(red: 0.2, green: 0.6, blue: 0.4), .black], center: .center, startRadius: 0, endRadius: 1800)
                HStack {
                    VStack {
                        // Token Info
                        // FIXME: Make size constant
                        Token(description: (nil, pokerEngine.points, true))
                        .padding(.bottom, 40)
                        
                        // Figures
                        VStack {
                            ForEach(Card.allCases){ rank in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(.white)
                                    Image(rank.description)
                                        .resizable()
                                        .scaledToFit()
                                        .padding(2)
                                }
                                .frame(width: 50, height: 50)
                            }
                        }
                    }
                    Spacer()
                    // Cards
                    TableCenter
                    Spacer()
                }
                .padding(50)
            }
        }
    }


    var TableCenter: some View {
        VStack {
            // Croupier
            HStack {
                if let dealerHand = pokerEngine.dealerHand {
                    ForEach(pokerEngine.dealerCards, id: \.self.0){
                        (card, selected) in
                        
                            CardView(showing: true, card: card)
                                .padding((dealerHand.cards.contains(card) ? .top : .bottom), 50)
                        }
                } else {
                    ForEach(pokerEngine.dealerCards, id: \.self.0){
                        (card, selected) in
                        CardView(showing: false, card: card)
                            .padding((selected ? .top : .bottom), 50)
                    }
                }
            }
            .foregroundStyle(.blue)
            Spacer()
            VStack {
                
                    if let playerHand = pokerEngine.playerHand, let dealerHand = pokerEngine.dealerHand {
                        Group {
                            HandLabel(hand: dealerHand.hand)
                            Spacer()
                            Text(pokerEngine.buttonMessage)
                                .font(.custom("Mayan", size: 24))
                            Spacer()
                            HandLabel(hand: playerHand.hand)
                        }
                        .onTapGesture {
                            pokerEngine.endRound()
                            pokerEngine.startRound()
                        }
                    } else {
                        Spacer()
//                        Image(pokerEngine.buttonMessage)
//                            .onTapGesture {
//                                pokerEngine.playerTurn()
//                            }
//                        Text(pokerEngine.buttonMessage)
//                            .font(.custom("Mayan", size: 24))
//                            .onTapGesture {
//                                pokerEngine.playerTurn()
//                            }
                        Button(action: {
                            pokerEngine.playerTurn()
                            print(pokerEngine.buttonMessage)
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerSize: .zero)
                                    .foregroundStyle(Color.orange)
                                Text(pokerEngine.buttonMessage)
                                    .font(.custom("Mayan", size: 60))
                                    .foregroundStyle(.black)
                                
                            }
                                
                        })
                        Spacer()
                    }
                    
                
            }
            .frame(height: 200)
            Spacer()
            // Player
            HStack {
                ForEach(pokerEngine.playerCards.indices, id: \.self) { index in
                    let card = pokerEngine.playerCards[index].0
                    let isSelected = pokerEngine.playerCards[index].1
                    
                    if let playerHand = pokerEngine.playerHand {
                        CardView(showing: true, card: card)
                            .padding(playerHand.cards.contains(card) ? .bottom : .top, 50)
                    } else {
                        //                    FIXME: This doesnt look very nice
                        
                        CardView(showing: true, card: card)
                            .padding(isSelected ? .bottom : .top, 50)
                            .onTapGesture {
                                SoundManager.instance.playLoop(forResource: "Card", volume: 0.7)
                                pokerEngine.playerCards[index].1.toggle()
                            }
                    }
                }
            }
            .foregroundStyle(.blue)
        }
//        SpriteView(scene: makeGameScene())
//            .frame(width: 300, height: 400) // Define the size of the SpriteKit view
//            .cornerRadius(15)
//            .shadow(radius: 10)
    }
    
//    func makeGameScene() -> SKScene {
//        let scene = GameScene(size: CGSize(width: 300, height: 400))
//        scene.scaleMode = .aspectFill
//        return scene
//    }
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
