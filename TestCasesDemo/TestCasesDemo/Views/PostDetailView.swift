//
//  PostDetailView.swift
//  TestCasesDemo
//
//  Created by Nitin Bhatia on 01/03/26.
//

import SwiftUI

struct PostDetailView: View {
    let post: Post

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(post.title)
                .font(.title2)
                .bold()

            Text(post.body)
                .font(.body)
                .accessibilityIdentifier("postBody")

            Spacer()
        }
        .padding()
        .navigationTitle("Details")
    }
}
