//
//  ContentView.swift
//  AnimatedThemeSwitcher
//
//  Created by Nitin Bhatia on 13/10/26.
//

import SwiftUI

struct ContentView: View {
    @State private var showPicker: Bool = false
    @State private var activeTheme: Theme = .light
    @Environment(\.colorScheme) private var colorScheme
        
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .themePicker(isPresented: $showPicker, value: $activeTheme, envColorScheme: colorScheme)
        .onAppear{ showPicker = true }
        .preferredColorScheme(activeTheme == .light ? .light : activeTheme == .dark ? .dark : nil)
    }
}

#Preview {
    ContentView()
}
