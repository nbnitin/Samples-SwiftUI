//
//  ContentView.swift
//  A-ZStrip
//
//  Created by Nitin Bhatia on 30/05/26.
//

import SwiftUI

struct ContentView: View {
    let allProducts = ProductCategory.mockData.sorted { $0.name < $1.name }
    var body: some View {
        List(allProducts) { category in
            Section(header: Text(category.name)) {
                ForEach(category.products) { item in
                    Text(item.name)
                }
            }
            .sectionIndexLabel(String(category.name.prefix(1)).uppercased())
        }
        .listSectionIndexVisibility(.visible)
    }
}

#Preview {
    ContentView()
}

