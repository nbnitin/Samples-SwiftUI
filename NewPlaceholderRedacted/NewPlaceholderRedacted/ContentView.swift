//
//  ContentView.swift
//  NewPlaceholderRedacted
//
//  Created by Nitin Bhatia on 04/04/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoading: Bool = true
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ScrollView {
            MovieView(isLoading: isLoading)
                .skeleton(isRedacted: isLoading)
                .animation(.easeInOut(duration: 0.5), value: isLoading)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.isLoading = false
            }
        }
        .background(colorScheme == .dark ? Color.black : Color.gray)
    }
}

#Preview {
    ContentView()
}
