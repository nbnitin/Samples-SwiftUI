//
//  ContentView.swift
//  Sampless
//
//  Created by Nitin Bhatia on 02/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selected = "Inbox"
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                NavigationLink("Latest", destination: {
                    WithoutToolBarItem()
                })
                NavigationLink("Old", destination:  {
                    WithToolBarItem()
                })
            }
        }
    }
}


#Preview {
    ContentView()
}
