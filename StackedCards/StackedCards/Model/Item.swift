//
//  Item.swift
//  StackedCards
//
//  Created by Nitin Bhatia on 07/03/24.
//

import SwiftUI

struct Item : Identifiable {
    var id : UUID = UUID()
    var color: Color
}

var items : [Item] = [
    .init(color: .red),
    .init(color: .blue),
    .init(color: .green),
    .init(color: .black),
    .init(color: .purple),
    .init(color: .yellow),
    .init(color: .pink)
]


extension [Item] {
    func zIndex(_ item: Item) -> CGFloat {
        if let index = firstIndex(where: {$0.id == item.id}) {
            return CGFloat(count) - CGFloat(index)
        }
        return .zero
    }
}
