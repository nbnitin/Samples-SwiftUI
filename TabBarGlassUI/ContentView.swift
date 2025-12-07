//
//  ContentView.swift
//  TaBarAccessory
//
//  Created by Nitin Bhatia on 25/11/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    TabBarAccessiory()
                } label: {
                    Text("Tab Bar Accessory")
                }
                
                NavigationLink {
                    Inbox()
                } label: {
                    Text("Inbox")
                }
                
                NavigationLink {
                    MyNotes()
                } label: {
                    Text("Notes")
                }
            }
            .listStyle(.plain)
            .navigationTitle("Tab Bar Example")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
