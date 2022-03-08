//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Landon Volkmann on 2/26/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
    
    @Published private var theme: MemoryTheme<String>
    @Published private var model: MemoryGame<String>
    
    
    enum EmojiTheme: CaseIterable {
        case halloween, travel, fruit, fashion, sports, tech
    }
    
    static func createTheme(from emojiTheme : EmojiTheme) -> MemoryTheme<String> {
        switch emojiTheme {
        case .halloween:
            return MemoryTheme<String>(name: "Spooky Time", contentSet: ["💀", "😈", "👻", "🎃", "🤡", "🕸","🦠","👽"], numberOfPairs: 8, color: "orange", id: 1)
        case .travel:
            return MemoryTheme<String>(name: "Travel Mode", contentSet: ["🚂", "✈️", "🚀", "🚗", "🚙", "🛳", "🚁", "🚛"], numberOfPairs: 8, color: "blue", id: 2)
        case .fruit:
            return MemoryTheme<String>(name: "Fruity", contentSet: ["🍎","🍌","🍇","🍉","🍊","🍓","🍑","🥭","🍍","🥥"], numberOfPairs: 10, color: "red", id: 3)
        case .fashion:
            return MemoryTheme<String>(name: "Fashionista", contentSet: ["🦺", "👔", "👕", "👖", "🧣", "🧤", "🧥", "🧦", "👗", "👘", "🥻", "🩴", "🩱", "🩲", "🩳", "👙", "👚"], numberOfPairs: 12, color: "pink", id: 4)
        case .sports:
            return MemoryTheme<String>(name: "Sportsball", contentSet: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱"], numberOfPairs: 10, color: "green", id: 5)
        case .tech:
            return MemoryTheme<String>(name: "Techy", contentSet: ["⌚️", "📱", "💻", "⌨️", "🖥", "🖨", "🖱", "🕹", "💾", "💿", "📸", "🎥", "📡", "🔋"], numberOfPairs: 8, color: "gray", id: 6)
            
        }

    }
    
    static func createMemoryGame(theme: MemoryTheme<String>) -> MemoryGame<String> {
        
        let numberOfPairs = min(theme.numberOfPairs, theme.contentSet.count)
        
        let contentSet : [String] = Array(theme.contentSet.shuffled()[0..<numberOfPairs])
        
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairs) { pairIndex in
            contentSet[pairIndex] }
    }
    
    static func createRandomGameTheme() -> MemoryTheme<String> {
        let randomTheme = EmojiTheme.allCases.randomElement()!
        return createTheme(from: randomTheme)
    }
    
    
    init() {
        let memorizeTheme = EmojiMemoryGame.createTheme(from: .halloween)
        model = EmojiMemoryGame.createMemoryGame(theme: memorizeTheme)
        theme = memorizeTheme
    }
    
    var cards: Array<Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    var themeColor: Color {
        if(theme.color == "orange") {
            return Color.orange
        } else if(theme.color == "red") {
            return Color.red
        } else if(theme.color == "blue") {
            return Color.blue
        } else if(theme.color == "pink") {
            return Color.pink
        } else if(theme.color == "green") {
            return Color.green
        } else if(theme.color == "gray") {
            return Color.gray
        } else {
            return Color.blue
        }
    }
    
    var themeName: String {
        return theme.name
    }
    
    // MARK: - Intent(s)

    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func createNewGame() {
        let memorizeTheme = EmojiMemoryGame.createRandomGameTheme()
        model = EmojiMemoryGame.createMemoryGame(theme: memorizeTheme)
        theme = memorizeTheme
    }
}
