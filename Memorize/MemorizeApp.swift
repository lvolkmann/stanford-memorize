//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Landon Volkmann on 2/3/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
