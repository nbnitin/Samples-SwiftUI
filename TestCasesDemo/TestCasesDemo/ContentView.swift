//
//  ContentView.swift
//  TestCasesDemo
//
//  Created by Nitin Bhatia on 01/03/26.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel: PostsViewModel = PostsViewModel()
    var body: some View {
        PostsListView()
    }
}

#Preview {
    ContentView()
}
