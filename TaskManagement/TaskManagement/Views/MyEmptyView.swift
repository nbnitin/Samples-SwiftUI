//
//  MyEmptyView.swift
//  TaskManagement
//
//  Created by Nitin Bhatia on 25/04/25.
//
import SwiftUI

struct ContentUnavailableView: View {
    var systemImage: String
    var title: String
    var description: String?

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: systemImage)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.gray.opacity(0.6))

            Text(title)
                .font(.title3)
                .fontWeight(.semibold)

            if let description {
                Text(description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

extension ContentUnavailableView {
    static var search: ContentUnavailableView {
        ContentUnavailableView(systemImage: "xmark.seal.fill", title: "No Taks Available", description: "Create your first task.")
    }
}
