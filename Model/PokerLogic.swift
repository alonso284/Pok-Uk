//
//  Logic.swift
//  Pok'Uk
//
//  Created by Alonso Huerta on 16/01/25.
//

import Foundation

enum Card: Int, CaseIterable, Comparable  {
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }

    case sun, mask, eagle, pelican, turtle, fish
}

extension Card: CustomStringConvertible, Identifiable {
    var description: String {
        switch self {
        case .mask:
            "Mask"
        case .eagle:
            "Eagle"
        case .fish:
            "Fish"
        case .pelican:
            "Pelican"
        case .sun:
            "Sun"
        case .turtle:
            "Turtle"
        }
    }
    
    var id : String { description }
}

struct Deck {
    private(set) var cards: [Card]

    init() {
        self.cards = Deck.generateDeck()
        assert(self.cards.count == Card.allCases.count * 5)
    }
  
    static func generateDeck() -> [Card] {
        var cards: [Card] = []
        for card in Card.allCases {
            for _ in 1...5 {
                cards.append(card)
            }
        }
        return cards
    }
  
    /// Make sure there are still enough cards available
    mutating func deal(count: Int) -> [Card] {
        guard count <= cards.count else {
            return []
        }
        cards.shuffle()
        let hand = cards.suffix(count)
        cards.removeLast(count)
        return Array(hand)
    }
    
    /// Deals one card if available
    mutating func dealOneCard() -> Card? {
        cards.shuffle()
        guard let card = self.cards.popLast() else {
            return nil
        }
        return card
    }
  
    mutating func reset() {
        self.cards = Deck.generateDeck()
    }
}

enum PokerHand: Int, Comparable, CaseIterable, CustomStringConvertible {
    var description: String {
        switch self {
        case .highCard:
            "High Card"
        case .pair:
            "Pair"
        case .twoPair:
            "Two Pair"
        case .threeOfAKind:
            "Three of a Kind"
        case .fullHouse:
            "Full House"
        case .fourOfAKind:
            "Four of a Kind"
        case .fiveOfAKind:
            "Five of a Kind"
        }
    }
    
  static func < (lhs: PokerHand, rhs: PokerHand) -> Bool {
    return lhs.rawValue < rhs.rawValue
  }
  case highCard = 1, pair, twoPair, threeOfAKind, fullHouse, fourOfAKind, fiveOfAKind
}

extension PokerHand {
    func isHand(cards: [Card]) -> [Card]? {
        switch self {
        case .highCard:
            if let maxNCard = cards.max() {
               return [maxNCard]
            } else {
                return nil
            }
        case .pair:
            return PokerHand.isPair(cards: cards)
        case .twoPair:
            return PokerHand.isTwoPair(cards: cards)
        case .threeOfAKind:
            return PokerHand.isThreeOfAKind(cards: cards)
        case .fullHouse:
            return PokerHand.isFullHouse(cards: cards)
        case .fourOfAKind:
            return PokerHand.isFourOfAKind(cards: cards)
        case .fiveOfAKind:
            return PokerHand.isFiveOfAKind(cards: cards)
        }
    }
    
    private static func isFiveOfAKind(cards: [Card]) -> [Card]? {
        let filtered = cards.allRanksWithCount().filter({$1 == 5})
        if filtered.count == 1 {
            return Array(filtered.keys).sorted()
        } else {
            return nil
        }
    }
    
    private static func isFourOfAKind(cards: [Card]) -> [Card]? {
        let filtered = cards.allRanksWithCount().filter({$1 == 4})
        if filtered.count == 1 {
            return Array(filtered.keys).sorted()
        } else {
            return nil
        }
    }
    
    private static func isFullHouse(cards: [Card]) -> [Card]? {
        if let pair = isPair(cards: cards), let threeOfAKind = isThreeOfAKind(cards: cards) {
            return threeOfAKind + pair
        } else {
            return nil
        }
    }

    private static func isThreeOfAKind(cards: [Card]) -> [Card]? {
        let filtered = cards.allRanksWithCount().filter({$1 == 3})
        if filtered.count == 1 {
            return Array(filtered.keys).sorted()
        } else {
            return nil
        }
    }

    private static func isTwoPair(cards: [Card]) -> [Card]? {
        let filtered = cards.allRanksWithCount().filter({$1 == 2})
        if filtered.count == 2 {
            return Array(filtered.keys).sorted()
        } else {
            return nil
        }
    }

    private static func isPair(cards: [Card]) -> [Card]? {
        let filtered = cards.allRanksWithCount().filter({$1 == 2})
        if filtered.count == 1 {
            return Array(filtered.keys).sorted()
        } else {
            return nil
        }
    }
}

extension Array where Element == Card {
    func allRanksWithCount() -> [Card: Int] {
        var result: [Card: Int] = [:]
        for card in self {
            result[card] = (result[card] ?? 0) + 1
        }
        return result
    }
}

func compareHands(lhs: (PokerHand, [Card]), rhs: (PokerHand, [Card])) -> Bool {
    // Compare PokerHands first
    if lhs.0 != rhs.0 {
        return lhs.0 < rhs.0
    }
    // If PokerHands are equal, compare the [Card] arrays lexicographically
    return rhs.1.lexicographicallyPrecedes(lhs.1)
}
