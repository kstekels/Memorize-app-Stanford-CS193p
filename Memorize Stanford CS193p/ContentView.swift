//
//  ContentView.swift
//  Memorize Stanford CS193p
//
//  Created by karlis.stekels on 20/10/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var emojiCount = 10
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
        }
        .padding(.horizontal)
    }
    
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if isFaceUp {
                shape.fill().foregroundColor(.white) // Type inference, it is looking automatecally in struct Color
                shape.strokeBorder(lineWidth: 3) // Only outside edge
                
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
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 12 mini")
        ContentView()
            .preferredColorScheme(.light)
            .previewDevice("iPhone 12 mini")
    }
}
