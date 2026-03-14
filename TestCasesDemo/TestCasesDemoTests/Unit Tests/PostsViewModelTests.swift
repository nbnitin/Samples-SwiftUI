//
//  PostsViewModelTests.swift
//  TestCasesDemo
//
//  Created by Nitin Bhatia on 01/03/26.
//

@testable import TestCasesDemo
import Foundation
import Testing

@MainActor
struct PostsViewModelTests {

    // Test successful fetch
    @Test func test_loadPosts_success() async {
        // GIVEN
        let mockPosts = [
            Post(id: 1, title: "Test", body: "Body")
        ]
        let mockService = MockNetworkService(result: .success(mockPosts))
        let viewModel = PostsViewModel(service: mockService)

        // WHEN
        await viewModel.loadPosts()

        // THEN
        #expect(viewModel.posts == mockPosts, "Posts should match the mock data")
        #expect(!viewModel.isLoading, "Loading state should be false after fetch")
        #expect(viewModel.errorMessage == nil, "Error message should be nil")
    }

//    // Test failure fetch
    func test_loadPosts_failure() async {
        // GIVEN
        let mockService = MockNetworkService(result: .failure(URLError(.badServerResponse)))
        let viewModel = PostsViewModel(service: mockService)

        // WHEN
        await viewModel.loadPosts()

        // THEN
        assert(viewModel.posts.isEmpty, "Posts should be empty on failure")
        assert(!viewModel.isLoading, "Loading state should be false")
        assert(viewModel.errorMessage == "Failed to load posts", "Error message should be set")
    }

    // Test loading state toggles correctly
   @Test func test_loadPosts_setsLoadingState() async {
        let mockService = MockNetworkService(result: .success([]))
        let viewModel = PostsViewModel(service: mockService)

        #expect(!viewModel.isLoading, "Initially loading should be false")

        await viewModel.loadPosts()

        #expect(!viewModel.isLoading, "Loading should be false after fetch")
    }

    // Test fetch happens only once
    @Test func test_loadPosts_doesNotFetchTwice() async {
        let mockPosts = [
            Post(id: 1, title: "Once", body: "Only once")
        ]
        let mockService = MockNetworkService(result: .success(mockPosts))
        let viewModel = PostsViewModel(service: mockService)

        await viewModel.loadPosts()
        await viewModel.loadPosts() // second call

        #expect(viewModel.posts.count == 1, "Posts should only be loaded once")
    }
}

