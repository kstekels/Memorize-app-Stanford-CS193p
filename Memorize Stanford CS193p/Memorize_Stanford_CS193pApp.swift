//
//  Memorize_Stanford_CS193pApp.swift
//  Memorize Stanford CS193p
//
//  Created by karlis.stekels on 20/10/2021.
//

import SwiftUI

@main
struct Memorize_Stanford_CS193pApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
