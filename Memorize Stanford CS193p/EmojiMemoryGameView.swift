//
//  ContentView.swift
//  Memorize Stanford CS193p
//
//  Created by karlis.stekels on 20/10/2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack{
                gameBody
                deckBody
                HStack{
                    restart
                    Spacer()
                    shuffle
                }
                .padding(.horizontal)
                
            }
        }
        .padding()
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: {$0.id == card.id}) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(game.cards.count))
        }
            
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
            cardView(for: card)
        })
//        .onAppear{
//            withAnimation(.easeInOut(duration: 5)) {
//                for card in game.cards {
//                    deal(card)
//                }
//            }
//
//        }
        .foregroundColor(.red)
    }
    
    
    private func zIndex(of card: EmojiMemoryGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card))

            }
        }
        .frame(width: CardConstants.undealWidth, height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 5)) {
                for card in game.cards {
                    withAnimation(dealAnimation(for: card)) {
                        deal(card)
                    }
                }
                
            }
        }
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                game.shuffle()
            }
            
        }
    }
    
    var restart: some View {
        Button("Restart") {
            withAnimation {
                dealt = []
                game.restart()
            }
        }
    }
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight:CGFloat = 90
        static let undealtWidth: CGFloat = 90
        static let undealWidth = undealtHeight * aspectRatio
    }
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if isUndealt(card) || card.isMatched && !card.isFaceUp {
            Color.clear
        } else {
            CardView(card: card)
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .padding(4)
                .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                .zIndex(zIndex(of: card))
                .onTapGesture {
                    withAnimation() {
                        game.choose(card)
                    }
                    
                }
        }
    }
    
}

struct CardView: View {
    
    let card: EmojiMemoryGame.Card
    
    @State private var animatedBonusRemaining: Double = 0.0

    var body: some View {
        
        GeometryReader(content: { geometry in
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-animatedBonusRemaining)*360-90))
                            .onAppear{
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    }else{
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-card.bonusRemaining)*360-90))
                    }
                }
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
