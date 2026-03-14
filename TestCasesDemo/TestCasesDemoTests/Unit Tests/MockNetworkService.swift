//
//  MockNetworkService.swift
//  TestCasesDemo
//
//  Created by Nitin Bhatia on 01/03/26.
//

@testable import TestCasesDemo
import Foundation
import Testing

@MainActor
struct MockNetworkService: NetworkService {

    var result: Result<[Post], Error>

    init(result: Result<[Post], Error>) {
        self.result = result
    }

    func fetchPosts() async throws -> [Post] {
        try result.get()
    }
    
    
    
}

