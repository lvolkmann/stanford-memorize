//
//  MemoryGame.swift
//  Memorize
//
//  Created by Landon Volkmann on 2/26/22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
        
    private(set) var score: Int
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched  = true
                    score += 2
                } else {
                    if cards[chosenIndex].isPreviouslySeen {
                        score -= 1
                    }
                    if cards[potentialMatchIndex].isPreviouslySeen {
                        score -= 1
                    }
                }
                cards[chosenIndex].isPreviouslySeen = true
                cards[potentialMatchIndex].isPreviouslySeen = true
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        // add cards in pairs of two
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id:pairIndex * 2))
            cards.append(Card(content: content, id:pairIndex * 2 + 1))
        }
        cards.shuffle()
        score = 0
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var isPreviouslySeen = false
        let content: CardContent
        let id: Int
    }
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
