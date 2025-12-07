//
//  InboxModel.swift
//  TaBarAccessory
//
//  Created by Nitin Bhatia on 06/12/25.
//

import Foundation

struct InboxModel: Identifiable {
    var id: UUID = UUID()
    var title: String
    var subtitle: String
    var image: String
    
    init(title: String, subtitle: String, image: String) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
    
    static func getInboxData() -> [InboxModel] {
        return [
            InboxModel(title: "Title 1", subtitle: "Subtitle 1", image: "image1"),
            InboxModel(title: "Title 2", subtitle: "Subtitle 2", image: "image2"),
            InboxModel(title: "Title 3", subtitle: "Subtitle 3", image: "image3"),
        ]
    }
    
}
