//
//  PokerEngine.swift
//  Pok'Uk
//
//  Created by Alonso Huerta on 17/01/25.
//

import Foundation


// FIXME: Move to another class
class PokerEngine: ObservableObject {
    
    // FIXME: Move to engine object
    @Published private var _points:  UInt = 99
    var points : UInt { return self._points }
    @Published private var _bet:      UInt = 0
    var bet : UInt { return self._bet }
    
    @Published var playerCards: [(Card, Bool)] = []
    @Published var dealerCards: [(Card, Bool)] = []
    
    @Published var playerHand: (hand: PokerHand, cards: [Card])?
    @Published var dealerHand: (hand: PokerHand, cards: [Card])?
    
    @Published var deck: Deck = Deck()
    
    var playerSelected: Int {
        self.playerCards.filter({ $1 }).count
    }
    
    enum GameState {
        case win, lose, draw
    }
    
    var endGameState: GameState? {
        if let playerHand, let dealerHand {
            // Win
            if compareHands(lhs: dealerHand, rhs: playerHand)  {
                return .win
            }
            // Lose
            else if compareHands(lhs: playerHand, rhs: dealerHand) {
                return .lose
            } else {
                return .draw
            }
        } else {
            return nil
        }
    }
    
    var buttonMessage: String {
        switch endGameState {
        case .win:
            return "You Win"
        case .lose:
            return "You Lose"
        case .draw:
            return "Draw!"
        case nil:
            if  playerSelected > 0
            { return "Draw" }
            else
            { return "Hold" }
        }
        
    }
    
    var roundStarted: Bool {
        self.playerHand != nil
    }
    
    init() {
        startRound()
    }
    
    func restartGame() {
        _points = 0
        _bet = 0
        restartRound()
    }
    
    func restartRound() {
        self.playerHand = nil
        self.dealerHand = nil
        self.playerCards.removeAll()
        self.dealerCards.removeAll()
        self.deck.reset()
    }
    
    func startRound() {
        restartRound()
        
        let playerCardsDelt = deck.deal(count: 5)
        for card in playerCardsDelt {
            playerCards.append((card, false))
        }
        let dealerCardsDelt = deck.deal(count: 5)
        for card in dealerCardsDelt {
            dealerCards.append((card, false))
        }
    }
    
    func endRound() {
        if let playerHand, let dealerHand {
            // Win
            if compareHands(lhs: dealerHand, rhs: playerHand)  {
                self._points += self._bet
            }
            // Lose
            else if compareHands(lhs: playerHand, rhs: dealerHand) {
                self._bet = 0
            }
        }
        // Draw
        self._points += self._bet
        self._bet = 0
        return
    }
    
    func increaseBet() {
        if playerHand == nil && points > 0 {
            _bet += 1
            _points -= 1
        }
    }
    
    func decreaseBet() {
        if playerHand == nil && bet > 0 {
            _bet -= 1
            _points += 1
        }
    }
    
    func resetBet() {
        if playerHand == nil {
            _points += bet
            _bet = 0
        }
    }
    
    func playerTurn() {
        for index in playerCards.indices {
            if playerCards[index].1 {
                if let replacement = deck.dealOneCard() {
                    playerCards[index].0 = replacement
                    print("here")
                } else {
                    print("wtf")
                }
                playerCards[index].1 = false
            }
        }
        print("chaning player turn status")
        self.playerHand = self.detectHand(cards: playerCards.map { $0.0 })
        self.dealerHand = self.detectHand(cards: dealerCards.map { $0.0 })
        
        // FIXME: Sort accordingly
        switch endGameState {
        case .win:
            SoundManager.instance.playLoop(forResource: "Win", volume: 0.8)
        case .lose:
            SoundManager.instance.playLoop(forResource: "Lose", volume: 0.8)
        default:
            return
        }
    }
    
    func detectHand(cards: [Card]) -> (PokerHand, [Card])? {

        guard cards.count == 5 else {
            print("Bozo")
            return nil
        }

        for possibleHand in PokerHand.allCases.reversed() {
            if let score = possibleHand.isHand(cards: cards) {
                return (possibleHand, score)
            }
        }
            
        return nil
    }
}
