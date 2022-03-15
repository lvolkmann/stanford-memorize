//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Landon Volkmann on 2/3/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {

    @ObservedObject var game: EmojiMemoryGame
        
    @State var emojiCount = 6
    
    var body: some View {
        
        
        VStack {
            Text("\(game.themeName)")
                .font(.largeTitle)
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                CardView(card: card, color: game.themeColor)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }
            }
            .foregroundColor(game.themeColor)
            Spacer()
            VStack {
                Text("Score: \(game.score)")
                    .font(.title2)
                    .padding()
                Button {
                    game.createNewGame()
                } label: {
                    Text("New Game")
                }
            .font(.largeTitle)
        }
    }
    .padding(.horizontal)
    
}
    

}

struct CardView: View {
    var card: EmojiMemoryGame.Card
    var color: Color
    
    var body: some View {
        
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    // TODO: extract constants
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                        .padding(5)
                        .opacity(0.5)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                }
                else {
                    shape.fill().foregroundColor(color)
                }
            }
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.70
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
.previewInterfaceOrientation(.portrait)
//        EmojiMemoryGameView(game: game)
//            .preferredColorScheme(.dark)
    }
}
