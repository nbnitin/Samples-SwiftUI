//
//  TabBarAccessiory.swift
//  TaBarAccessory
//
//  Created by Nitin Bhatia on 07/12/25.
//

import SwiftUI

struct TabBarAccessiory: View {
    @State var search: String = ""
    @State var enabled: Bool = true
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "homekit") {
                List(0 ..< 100) {i in
                    Text("Home \(i)")
                }
            }
            Tab("Promote", systemImage: "square.and.pencil") {
                List(0 ..< 100) {i in
                    Text("Promote \(i)")
                }
            }
            
        }
        .searchable(text: $search, isPresented: $enabled)
        .tabBarMinimizeBehavior(.onScrollDown)
        .tabViewBottomAccessory {
            Menu("Order Options") {
                Button("Order Now", action: placeOrder)
                Button("Adjust Order", action: adjustOrder)
                Button("Cancel", action: cancelOrder)
            }
        }
    }
    
    func placeOrder() { }
    func adjustOrder() { }
    func cancelOrder() { }
}

#Preview {
    TabBarAccessiory(search: "", enabled: true)
}
