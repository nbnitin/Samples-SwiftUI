//
//  SectionItem.swift
//  Accordion
//
//  Created by Nitin Bhatia on 24/05/25.
//

import SwiftUI

struct SectionItem: Identifiable {
    let id = UUID()
    let title: String
    let content: String
    let strokeColor: Color
    
    init(title: String, content: String, strokeColor: Color) {
        self.title = title
        self.content = content
        self.strokeColor = strokeColor
    }
}

extension SectionItem {
    static func createDataSource() -> [SectionItem] {
        let sections = [
               SectionItem(title: "Section 1", content: "Details for Section 1", strokeColor: .blue),
               SectionItem(title: "Section 2", content: "Details for Section 2", strokeColor: .red),
               SectionItem(title: "Section 3", content: "Details for Section 3", strokeColor: .yellow),
               SectionItem(title: "Section 4", content: "Details for Section 4", strokeColor: .green)
           ]
        return sections
    }
}
