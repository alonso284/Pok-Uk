//
//  PokerEngine.swift
//  Pok'Uk
//
//  Created by Alonso Huerta on 17/01/25.
//

import Foundation
import SwiftUI


class PokerEngine: ObservableObject {
    
    // Achievements
    // Play N hands
    // Win N hands
    // Win with X Hand N Times
    // Answer N trivia questions correctly
    
    @StateObject var triviaFacts = FactViewModel()
    
    let maxBet: UInt = 25
    let initialPoints: UInt = 10
    
    @Published private var _points:  UInt = 0
    var points : UInt { return self._points }
    @Published private var _bet:      UInt = 0
    var bet : UInt { return self._bet }
    
    @Published private var _won:  UInt = 0
    var won : UInt { return self._won }
    @Published private var _lost:      UInt = 0
    var lost : UInt { return self._lost }
    @Published private var _drawn:      UInt = 0
    var drawn : UInt { return self._drawn }
    
    var handsPlayed : UInt { return self._drawn + self._won + self._lost }
    
    @Published var correctTriviaQuestions: UInt = 0
    
    @Published private var _previousBet: UInt = 0
    var previousBet : UInt { return self._previousBet }
    
    @Published var playerCards: [(card: Card, selected: Bool, showing: Bool)] = []
    @Published var dealerCards: [(card: Card, selected: Bool, showing: Bool)] = []
    
    @Published var playerHand: (hand: PokerHand, cards: [Card])?
    @Published var dealerHand: (hand: PokerHand, cards: [Card])?
    
    @Published var deck: Deck = Deck()
    
    @Published var achievementsClaimed: [Int] = []

    
    var playerSelected: Int {
        self.playerCards.filter { $0.selected }.count
    }
    
    var level: UInt {
        if points + bet == 0 {
            return 0
        }
        return UInt(max(0, Int(log(Double(points + bet)) / log(12)) - 1))
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
    
    var croupierMessage: String {
        switch endGameState {
        case .win:
            return "You won, but I’ll get you next time!"
        case .lose:
            return "Better luck next time!"
        case .draw:
            return "Hmmm... a tie."
        case nil:
            return "Let’s play!"
        }
    }
    
    @Published var determiningWinner: Bool = false
    var buttonMessage: String {
        switch endGameState {
        case .win:
            return "You Win!"
        case .lose:
            return "You Lose!"
        case .draw:
            return "It's a tie!"
        case nil:
            if determiningWinner {
                return "Drawing cards..."
            } else {
                if  playerSelected > 0
                { return "Draw \(playerSelected)" }
                else
                { return "Hold" }
            }
        }
        
    }
    
    var roundStarted: Bool {
        self.playerHand != nil
    }
    
    init() {
        restartGame()
    }
    
    func restartGame() {
        self.startRound()
        _points = 1
        _bet = 0
        _previousBet = 0
        _won = 0
        _lost = 0
        _drawn = 0
        achievementsClaimed = []
        
        self.correctTriviaQuestions = 0
        self.emote = nil
        self.feedback = nil
        self.fact = nil
        self.givingReward = false
        self.givingTriviaReward = false
        
        for i in 1...Int(self.initialPoints - 1) {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.12) {
                SoundManager.instance.playLoop(forResource: "Coin", volume: 1, times: 1)
                
                
                self._points += 1
                if self.points == self.initialPoints {
                    self._bet = 0
                }
                    
            }
        }
    }
    
    func rewardPlayer(_ amount: UInt) {
        for i in 1...Int(amount) {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.12) {
                SoundManager.instance.playLoop(forResource: "Coin", volume: 1, times: 1)
                self._points += 1
            }
        }
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
            playerCards.append((card, false, true))
        }
        let dealerCardsDelt = deck.deal(count: 5)
        for card in dealerCardsDelt {
            dealerCards.append((card, false, false))
        }
    }
    
    func endRound() {
        if let playerHand, let dealerHand {
            // Win
            if compareHands(lhs: dealerHand, rhs: playerHand)  {
                _won += 1
                betOutcome(result: true)
            }
            // Lose
            else if compareHands(lhs: playerHand, rhs: dealerHand) {
                _lost += 1
                betOutcome(result: false)
            }
            // Tie
            else {
                _drawn += 1
                betOutcome(result: nil)
            }
        }
    }
    
    @Published var fact: Fact? = nil
    func startTrivia() {
        guard let newFact = triviaFacts.getRandomFact() else {
            self.startRound()
            self.givingReward = false
            return
        }
        self.fact = newFact
    }
    
    @Published var feedback: String?
    @Published var emote: Bool?
    @Published var givingTriviaReward: Bool = false
    func answerTrivia(answer: Bool){
        givingTriviaReward = true
        if let fact {
            if answer == fact.answer {
                emote = true
                feedback = fact.right
            } else {
                emote = false
                feedback = fact.wrong
            }
            
            if answer == fact.answer {
                correctTriviaQuestions += 1
                var completedTasks = 0
                for i in 1...self.previousBet {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.12) {
                        SoundManager.instance.playLoop(forResource: "Coin", volume: 1, times: 1)
                        self._points += 1
                        completedTasks += 1
                        if completedTasks == self.previousBet {
                            self.givingTriviaReward = false
                        }
                    }
                }
            } else {
                self.givingTriviaReward = false
            }
        }
        
    }
    
    func endTrivia() {
        self.emote = nil
        self.feedback = nil
        self.fact = nil
        self.givingReward = false
        self.givingTriviaReward = false
        self.startRound()
    }
    
    @Published var givingReward: Bool = false
    func betOutcome(result: Bool?) {
        self.givingReward = true
        self._previousBet = self._bet
        var completedTasks = 0
        
        for i in 1...Int(self._previousBet) {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.12) {
                SoundManager.instance.playLoop(forResource: "Coin", volume: 1, times: 1)
                
                switch result {
                case true:
                    self._points += 2
                case false:
                    self._points -= 0
                default:
                    self._points += 1
                }
                self._bet -= 1
                completedTasks += 1
                
                if completedTasks == self.previousBet {
                    if result == false && self.points + self.bet > 0 {
                        self.startTrivia()
                    } else {
                        self.startRound()
                        self.givingReward = false
                    }
                }
            }
        }
    }
    
    func increaseBet() {
        if playerHand == nil && points > 0 && bet < maxBet {
            _bet += 1
            _points -= 1
            SoundManager.instance.playLoop(forResource: "Coin", volume: 1)
        }
    }
    
    func decreaseBet() {
        if playerHand == nil && bet > 0 {
            _bet -= 1
            _points += 1
            SoundManager.instance.playLoop(forResource: "Coin", volume: 1)
        }
    }
    
    func allInBet() {
        if playerHand == nil {
            resetBet()
            _bet = min(maxBet, _points)
            _points -= _bet
            SoundManager.instance.playLoop(forResource: "Coin", volume: 1)
        }
    }
    
    func resetBet() {
        if playerHand == nil {
            _points += bet
            _bet = 0
            SoundManager.instance.playLoop(forResource: "Coin", volume: 1)
        }
    }
    
    func playerTurn() {
        withAnimation {
            determiningWinner = true
        }
        
        let drawnCard = playerSelected
        for index in playerCards.indices {
            if playerCards[index].selected {
                // Hide the card
                SoundManager.instance.playLoop(forResource: "Card", volume: 0.7)
                playerCards[index].showing = false

                // Delay to allow the hide animation to complete
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    if let replacement = self.deck.dealOneCard() {
                        // Replace the card
                        self.playerCards[index].card = replacement

                        // Show the new card after a short delay
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.playerCards[index].showing = true
                            SoundManager.instance.playLoop(forResource: "Card", volume: 0.7)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                SoundManager.instance.playLoop(forResource: "Card", volume: 0.7)
                                self.playerCards[index].selected = false
                            }
                        }
                    }
                    
                }
            }
        }

        // Update hands after all animations are complete
        DispatchQueue.main.asyncAfter(deadline: .now() + (drawnCard > 0 ? 2 : 0)) {
            
            for index in self.dealerCards.indices {
                self.dealerCards[index].showing = true
            }
            self.playerHand = self.detectHand(cards: self.playerCards.map { $0.card })
            self.dealerHand = self.detectHand(cards: self.dealerCards.map { $0.card })
            
            self._previousBet = self.bet
            
            // Handle end game state
            switch self.endGameState {
            case .win:
                SoundManager.instance.playLoop(forResource: "Win", volume: 0.8)
            case .lose:
                SoundManager.instance.playLoop(forResource: "Lose", volume: 0.8)
            default:
                break
            }
            withAnimation {
                self.determiningWinner = false
            }
        }
    }
    
    func croupierStrategy() {
        
    }
    
    
    func detectHand(cards: [Card]) -> (PokerHand, [Card])? {

        guard cards.count == 5 else {
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
