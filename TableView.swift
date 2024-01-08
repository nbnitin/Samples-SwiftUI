//
//  ContentView.swift
//  TableView
//
//  Created by Nitin Bhatia on 29/11/23.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    var item: String
    var description: String = "This is the item description"
    var quantity: Int = 1
    var price: Double = 0
}


struct ContentView: View {
    
    let data = [
        Item(item: "Image 1", quantity: 2, price: 1.99),
        Item(item: "Image 2", quantity: 1, price: 3.99),
        Item(item: "Image 3", quantity: 5, price: 9.99),
    ]
    
    let columns = [
        GridItem(.flexible(), alignment: .topLeading),
        GridItem(.flexible(minimum: 150), alignment: .topLeading),
        GridItem(.flexible(), alignment: .topLeading),
        GridItem(.flexible(), alignment: .topLeading),
    ]
    
    var body: some View {
        
        LazyVGrid(columns: columns) {
            
            // headers
            Group {
                Text("Item")
                Text("")
                Text("Qty")
                Text("Price")
            }
            .font(.headline)
            
            // content
            ForEach(data) { item in
                Text(item.item)
                Text(item.description)
                Text("\(item.quantity)")
                Text("$\(item.price, specifier: "%.2f")")
            }
        }
        .padding()
    }
}
#Preview {
    ContentView()
}
