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
        AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
            cardView(for: card)
        })
        .foregroundColor(.red)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if card.isMatched && !card.isFaceUp {
            Rectangle().opacity(0)
        } else {
            CardView(card: card)
                .padding(4)
                .onTapGesture {
                    game.choose(card)
                }
        }
    }
    
}

struct CardView: View {
    
    let card: EmojiMemoryGame.Card

    var body: some View {
        
        GeometryReader(content: { geometry in
            ZStack {
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                    .opacity(0.5)
                    .padding(5)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
//                    .font(font(in: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        })
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
        
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.65
        static let fontSize: CGFloat = 32
    }
    
}



























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
    }
}
