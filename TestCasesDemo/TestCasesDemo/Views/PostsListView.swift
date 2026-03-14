//
//  PostsListView.swift
//  TestCasesDemo
//
//  Created by Nitin Bhatia on 01/03/26.
//

import SwiftUI

struct PostsListView: View {
    @State private var viewModel : PostsViewModel = .init()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.errorMessage {
                    Text(error)
                } else {
                    List(viewModel.posts) { post in
                        NavigationLink(value: post) {
                            Text(post.title)
                                .font(.headline)
                                .accessibilityIdentifier("postTitle")
                        }
                    }
                }
            }
            .navigationTitle("Posts")
            .navigationDestination(for: Post.self) { post in
                PostDetailView(post: post)
            }
            .task {
                if viewModel.posts.isEmpty {
                    await viewModel.loadPosts()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
