//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Landon Volkmann on 2/26/22.
//

import SwiftUI

class EmojiMemoryGame {
    
    static let travelEmojis = ["🚂", "✈️", "🚀", "🚗", "🚙", "🛳", "🚁", "🚛"]
    static let halloweenEmojis = ["💀", "😈", "👻", "🎃", "🤡", "🕸","🦠","👽"]
    static let fruitEmojis = ["🍎","🍌","🍇","🍉","🍊","🍓","🍑","🥭","🍍","🥥"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            halloweenEmojis[pairIndex] }
    }
    
    private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
}
