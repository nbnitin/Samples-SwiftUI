//
//  ContentView 2.swift
//  Sampless
//
//  Created by Nitin Bhatia on 02/10/25.
//

//its for iOS 16 and previous and gives more control over placement
import SwiftUI

struct WithToolBarItem: View {
    @State private var selected = "Inbox"
    
    var body: some View {
        NavigationStack {
            Text("Selected: \(selected)")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Menu {
                            Button("Inbox") { selected = "Inbox" }
                            Button("Personal") { selected = "Personal" }
                            Button("Work") { selected = "Work" }
                        } label: {
                            HStack(spacing: 4) {
                                Text(selected) // current selection
                                    .font(.headline)
                                Image(systemName: "chevron.down")
                                    .font(.caption)
                            }
                        }
                    }
                }
        }
    }
}

#Preview {
    WithToolBarItem()
}
