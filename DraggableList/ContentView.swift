//
//  ContentView.swift
//  DraggableList
//
//  Created by Nitin Bhatia on 05/10/24.
//

import SwiftUI

struct ContentView: View {
    @State var episodes : [Episodes] = MockData.episodes
    var body: some View {
        NavigationStack {
            List {
                ForEach($episodes) { episode in
                    HStack {
                        Rectangle()
                            .frame(width: 100, height: 100)
                            .foregroundStyle(episode.color.wrappedValue)
                            .cornerRadius(8)
                        VStack(alignment: .leading) {
                            Text(episode.title.wrappedValue)
                                .font(.headline)
                            Text(episode.description.wrappedValue)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.leading, 8)
                    }
                }
                .onMove{ indexSet, destination in
                    episodes.move(fromOffsets: indexSet, toOffset: destination)
                    var counter = 0
                    for episode in episodes {
                        episode.listOrder = counter
                        counter += 1
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}


class Episodes: Identifiable, Equatable {
   
    let id = UUID()
    var title: String
    var description: String
    var color: Color
    var listOrder: Int
    
    init(title: String, description: String, color: Color, listOrder: Int) {
        self.title = title
        self.description = description
        self.color = color
        self.listOrder = listOrder
    }
    
    static func == (lhs: Episodes, rhs: Episodes) -> Bool {
        lhs.id == rhs.id
    }
    
    
}

struct MockData {
    static var episodes: [Episodes] {
        [
            Episodes(title: "Pink Episode", description: "A journey through a world of calm and serenity.", color: .pink, listOrder: 0),
            Episodes(title: "Blue Episode", description: "Explore the vastness of the ocean and the sky.", color: .blue, listOrder: 1),
            Episodes(title: "Green Episode", description: "Dive into the lush landscapes of nature's beauty.", color: .green, listOrder: 2),
            Episodes(title: "Yellow Episode", description: "Feel the warmth and energy of the bright sunshine.", color: .yellow, listOrder: 3),
            Episodes(title: "Red Episode", description: "An intense and passionate adventure awaits.", color: .red, listOrder: 4),
            Episodes(title: "Purple Episode", description: "A mystical and royal tale unfolds.", color: .purple, listOrder: 5),
            Episodes(title: "Orange Episode", description: "Vibrant, lively, and full of zest.", color: .orange, listOrder: 6),
            Episodes(title: "Mint Episode", description: "A refreshing and cool episode, full of tranquility.", color: .mint, listOrder: 7),
            Episodes(title: "Teal Episode", description: "Bright and bold, with a dash of creativity.", color: .teal, listOrder: 8),
            Episodes(title: "Gray Episode", description: "A subdued and thoughtful journey through the unknown.", color: .gray, listOrder: 9),
            Episodes(title: "Cyan Episode", description: "Cool and calm, with a hint of excitement in the air.", color: .cyan, listOrder: 10),
        ]
    }
}
