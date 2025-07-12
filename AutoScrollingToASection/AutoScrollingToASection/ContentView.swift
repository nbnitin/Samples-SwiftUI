//
//  ContentView.swift
//  AutoScrollingToASection
//
//  Created by Nitin Bhatia on 12/07/25.
//

import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path){
            VStack(spacing: 20) {
                    Button("Tab View") {
                        path.append("TabView")
                    }
                Button("Navigation View") {
                    path.append("navigationView")
                }
            }
            .navigationDestination(for: String.self) { value in
                if value == "TabView" {
                    TabsView()
                } else {
                    HomeView(path: $path)
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
