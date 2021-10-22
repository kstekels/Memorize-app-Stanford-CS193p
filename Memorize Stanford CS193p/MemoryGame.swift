//
//  MemoryGame.swift
//  Memorize Stanford CS193p
//
//  Created by karlis.stekels on 21/10/2021.
//
// Model

import Foundation


struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            var faceUpCardIndices = [Int]()
            for index in cards.indices {
                if cards[index].isFaceUp {
                    faceUpCardIndices.append(index)
                }
            }
            if faceUpCardIndices.count == 1 {
                return faceUpCardIndices.first
            } else {
                return nil
            }
        }
        set {
            for index in cards.indices {
                if index != newValue { // Swift provides a new value inside in indexOfTheOneAndOnlyFaceUpCard 
                    cards[index].isFaceUp = false
                } else {
                    cards[index].isFaceUp = true
                }
                
            }
        }
        
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        { // , is the same && if -> if let
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
            cards[chosenIndex].isFaceUp.toggle()
        }
        print("\(cards)")
    }
    
    // content is don't care
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent){
        cards = []
        // add numberOfPairsOfCards x 2 to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: Int
    }
}
