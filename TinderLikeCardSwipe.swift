//
//  ContentView.swift
//  TinderLikeSwipeCards
//
//  Created by Nitin Bhatia on 08/03/24.
//

import SwiftUI

struct SwipeCard: View {
    @State private var offset: CGSize = .zero
    @State private var isDragging: Bool = false
    var card: Card
    
    var body: some View {
        GeometryReader {geometry  in
            VStack {
                ZStack {
                    Text(card.title)
                        .font(.title)
                        .padding()
                        .foregroundColor(.white)
                        .opacity(isDragging ? 0: 1.0)
                    
                    Text(offset.width < 0 ? "Keep Read" : "Keep Unread")
                        .font(.title)
                        .padding()
                        .foregroundColor(.white)
                        .opacity(isDragging ? 1.0 : 0)
                }
                
            }
            .frame(width: 300, height: 400)
            .background(card.color)
            .cornerRadius(20)
            .shadow(radius: 10)
            .offset(offset)
            .opacity(isDragging ? 0.5 : 1.0)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.offset = value.translation
                        self.isDragging = true
                        
                        
                    }
                    .onEnded { value in
                        withAnimation {
                            if self.offset.width < -100 {
                                self.offset.width = -500
                            } else if self.offset.width > 100 {
                                self.offset.width = 500
                            } else {
                                self.offset = .zero
                            }
                            self.isDragging = false
                        }
                    }
            )
            .rotationEffect(.degrees(Double(offset.width / 10)), anchor: .bottom)
            .animation(.snappy,value: 10)
            
        }
        .frame(width: 300, height: 400)
    }
}

struct Card {
    var id : UUID = UUID()
    var title: String
    var color: Color
}

struct SwipeCardsView: View {
    let cards: [Card] = [
        Card(title: "Card 1", color: .blue),
        Card(title: "Card 2", color: .green),
        Card(title: "Card 3", color: .orange),
        Card(title: "Card 4", color: .yellow),
        Card(title: "Card 5", color: .purple)
    ]
    
    var body: some View {
        ZStack {
            ForEach(cards, id: \.id) { card in
                SwipeCard(card: card)
                    .zIndex(self.zIndex(for: card))
            }
        }
        .padding()
    }
    
    func zIndex(for card: Card) -> Double {
        if let index = cards.firstIndex(where: { $0.title == card.title }) {
            return -Double(index)
        }
        return 0
    }
}

struct ContentView: View {
    var body: some View {
        SwipeCardsView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

