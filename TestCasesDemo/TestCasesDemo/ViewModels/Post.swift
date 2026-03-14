//
//  Post.swift
//  TestCasesDemo
//
//  Created by Nitin Bhatia on 01/03/26.
//


struct Post: Identifiable, Decodable, Equatable, Hashable {
    let id: Int
    let title: String
    let body: String
}
