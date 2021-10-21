//
//  EmojiMemoryGame.swift
//  Memorize Stanford CS193p
//
//  Created by karlis.stekels on 21/10/2021.
//


// ViewModel - class OOP
import SwiftUI


//func makeCardContent(index: Int) -> String{
//    return "👋"
//}

// Static is type property / type function | Global (Access by class name)


class EmojiMemoryGame: ObservableObject {
    
    static let emojis = ["✈️", "🚝", "🚁", "🚜", "🚗", "🚙", "🏎", "💩", "🤍", "😁", "👋", "💪",
                  "🤯", "🤢", "✍️", "🦾", "👇🏽", "🫁", "🧢", "🏀"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            EmojiMemoryGame.emojis[pairIndex]
        }
    }
        
    @Published private var model: MemoryGame<String> = createMemoryGame() // the same as -> EmojiMemoryGame.createMemoryGame() for outside of class itself
    
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
}
