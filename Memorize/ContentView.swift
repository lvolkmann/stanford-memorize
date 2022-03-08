//
//  ContentView.swift
//  Memorize
//
//  Created by Landon Volkmann on 2/3/22.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var viewModel: EmojiMemoryGame
        
    @State var emojiCount = 6
    
    var body: some View {
        
        
        VStack {
            Text("\(viewModel.themeName)")
                .font(.largeTitle)
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card, color: viewModel.themeColor).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }

                }
            }
            .foregroundColor(viewModel.themeColor)
            Spacer()
            VStack {
                Text("Score: \(viewModel.score)")
                    .font(.title2)
                    .padding()
                Button {
                    viewModel.createNewGame()
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
    var card: MemoryGame<String>.Card
    var color: Color
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            }
            else {
                shape.fill().foregroundColor(color)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
.previewInterfaceOrientation(.portrait)
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
