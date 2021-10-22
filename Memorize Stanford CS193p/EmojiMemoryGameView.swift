//
//  ContentView.swift
//  Memorize Stanford CS193p
//
//  Created by karlis.stekels on 20/10/2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(game.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }
                .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    
    let card: EmojiMemoryGame.Card

    var body: some View {
        
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white) // Type inference, it is looking automatecally in struct Color
                shape.strokeBorder(lineWidth: 3) // Only outside edge
                
                Text(card.content).font(.largeTitle)
            }else if card.isMatched {
                shape.opacity(0)
            }else {
                shape.fill()
            }
        }
    }
}



























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 12 mini")
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
            .previewDevice("iPhone 12 mini")
    }
}
