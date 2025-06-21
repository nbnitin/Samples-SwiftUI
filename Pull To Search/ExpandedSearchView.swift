//
//  ExpandedSearchView.swift
//  Pull To Search
//
//  Created by Nitin Bhatia on 20/06/25.
//

// Dummy Search View using List view

import SwiftUI
struct ExpandedSearchView: View {
    @FocusState.Binding var isExpanded: Bool
    @Binding var colors : [Color: [String]]
    
    var body: some View {
        let sortedKeys = Array(self.colors.keys).sorted(by: { $0.description < $1.description })
        List {
            if isExpanded {
                ForEach(Array(sortedKeys), id: \.self) { color in
                    let title = String(describing: color).capitalized
                        let items = colors[color] ?? []

                    Section(title) {
                        ForEach(items, id: \.self) { item in
                            HStack(spacing: 10) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(color.gradient)
                                    .frame(width: 40, height: 40)
                                
                                Text(item)
                            }
                        }
                        .listRowBackground(Color.clear)
                        .listRowInsets(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .clipped()
    }
}

#Preview {
    ContentView()
}
