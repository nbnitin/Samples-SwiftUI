//
//  PostsViewModel.swift
//  TestCasesDemo
//
//  Created by Nitin Bhatia on 01/03/26.
//


import SwiftUI
import Observation

@Observable
final class PostsViewModel {
    var posts: [Post] = []
    var isLoading = false
    var errorMessage: String?

    private let service: NetworkService

    init(service: NetworkService = APIService()) {
        self.service = service
    }

    func loadPosts() async {
        isLoading = true
        errorMessage = nil

        do {
            posts = try await service.fetchPosts()
        } catch {
            errorMessage = "Failed to load posts"
        }

        isLoading = false
    }
}

