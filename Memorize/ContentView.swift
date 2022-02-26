//
//  ContentView.swift
//  Memorize
//
//  Created by Landon Volkmann on 2/3/22.
//

import SwiftUI

struct ContentView: View {
//    @State var emojiGroup: EmojiGroup = EmojiGroup.travel
    @State var emojis = ["🚂", "✈️", "🚀", "🚗", "🚙", "🛳", "🚁", "🚛"]
        
    var travelEmojis = ["🚂", "✈️", "🚀", "🚗", "🚙", "🛳", "🚁", "🚛"]
    var halloweenEmojis = ["💀", "😈", "👻", "🎃", "🤡", "🕸","🦠","👽"]
    var fruitEmojis = ["🍎","🍌","🍇","🍉","🍊","🍓","🍑","🥭","🍍","🥥"]
        
    @State var emojiCount = 6
    
    var body: some View {
        
        
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self, content: { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    })

                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                Button {
                    emojis = halloweenEmojis.shuffled()
                } label: {
                    VStack {
                        Text("🎃")
                        Text("Halloween")
                            .font(.body)
                    }
                    .frame(maxWidth: .infinity)
                }
                Button {
                    emojis = travelEmojis.shuffled()
                } label: {
                    VStack {
                        Text("✈️")
                        Text("Travel")
                            .font(.body)
                    }
                    .frame(maxWidth: .infinity)
                }
                Button {
                    emojis = fruitEmojis.shuffled()
                } label: {
                    VStack {
                        Text("🍉")
                        Text("Fruit")
                        .font(.body)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .font(.largeTitle)
        }
        .padding(.horizontal)
    }
    
    
    var remove: some View {
        Button {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
        }
    }
    
    var add: some View {
        Button {
            if emojiCount < emojis.count{
                emojiCount += 1
            }
        } label: {
            Image(systemName: "plus.circle")
        }
    }
}

//struct PickThemeButton: View {
//    var displayEmoji: String
//    var emojiGroup: [String]
//
//    var body: some View {
//        Button {
//            emojis = emojiGroup
//        } label: {
//            Text(displayEmoji)
//        }
//    }
//}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
.previewInterfaceOrientation(.portrait)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
