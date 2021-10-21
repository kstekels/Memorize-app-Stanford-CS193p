//
//  MemoryGame.swift
//  Memorize Stanford CS193p
//
//  Created by karlis.stekels on 21/10/2021.
//
// Model

import Foundation


struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>
    
    func choose(_ card: Card) {
        
    }
    
    // content is don't care
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent){
        cards = Array<Card>()
        // add numberOfPairsOfCards x 2 to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    struct Card {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
