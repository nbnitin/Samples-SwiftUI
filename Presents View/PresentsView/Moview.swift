//
//  Moview.swift
//  SampleSwiftUI
//
//  Created by Nitin on 08/05/20.
//  Copyright © 2020 Nitin. All rights reserved.
//

import SwiftUI

//struct which holds the api data
struct Posts: Decodable, Identifiable {
    public var id: Int
    public var userId: Int
    public var title: String
    public var body : String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userId = "userId"
        case body = "body"
        case title = "title"
    }
}

//class to fetch posts
public class PostsFetcher: ObservableObject {
    //here published type variable, this type of variable can transfer value throught out the application, and it acts like global...
    @Published var posts = [Posts]()
    
    init(){
        load()
    }
    
    //func to call api
    func load() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        URLSession.shared.dataTask(with: url) {(data,response,error) in
            do {
                //decoding and creating object of post
                if let d = data {
                    let decodedLists = try JSONDecoder().decode([Posts].self, from: d)
                    DispatchQueue.main.async {
                        self.posts = decodedLists
                    }
                }else {
                    print("No Data")
                }
            } catch {
                print ("Error")
            }
            
        }.resume()
        
    }
}
