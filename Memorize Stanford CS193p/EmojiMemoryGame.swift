//
//  EmojiMemoryGame.swift
//  Memorize Stanford CS193p
//
//  Created by karlis.stekels on 21/10/2021.
//


// ViewModel - class OOP
import SwiftUI


//func makeCardContent(index: Int) -> String{
//    return "๐"
//}

// Static is type property / type function | Global (Access by class name)


class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static let emojis = ["โ๏ธ", "๐", "๐", "๐", "๐", "๐", "๐", "๐ฉ", "๐ค", "๐", "๐", "๐ช",
                  "๐คฏ", "๐คข", "โ๏ธ", "๐ฆพ", "๐๐ฝ", "๐ซ", "๐งข", "๐", "๐ฅ", "๐ฅ", "๐ฅฃ", "๐ฉ"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 10) { pairIndex in
            EmojiMemoryGame.emojis[pairIndex]
        }
    }
        
    @Published private var model = createMemoryGame() // the same as -> EmojiMemoryGame.createMemoryGame() for outside of class itself
    
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemoryGame()
    }
    
}

