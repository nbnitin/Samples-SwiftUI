//
//  NetworkService.swift
//  TestCasesDemo
//
//  Created by Nitin Bhatia on 01/03/26.
//

import Foundation

protocol NetworkService {
    func fetchPosts() async throws -> [Post]
}

final class APIService: NetworkService {
    func fetchPosts() async throws -> [Post] {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Post].self, from: data)
    }
}
