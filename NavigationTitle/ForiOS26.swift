//
//  ContentView 3.swift
//  Sampless
//
//  Created by Nitin Bhatia on 02/10/25.
//

//its for iOS 16+
import SwiftUI

struct WithoutToolBarItem: View {
    @State private var selected = "Inbox"
    
    var body: some View {
        NavigationStack {
            Text("Selected: \(selected)")
                .navigationTitle(selected)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarTitleMenu(content: {
                    Button("Inbox") { selected = "Inbox" }
                                       Button("Personal") { selected = "Personal" }
                                       Button("Work") { selected = "Work" }
                })
        }
    }
}


#Preview {
    ContentView()
}
