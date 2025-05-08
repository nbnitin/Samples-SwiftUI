//
//  TasksModel.swift
//  TaskManagement
//
//  Created by Nitin Bhatia on 28/04/25.
//

import SwiftUI
import SwiftData

@Model
public final class TasksModel: Identifiable {
    @Attribute(.unique) public var id: UUID
    public var title: String
    public var desc: String
    public var isCompleted: Bool
    public var date: Date? = Date()
    
    public init(id: UUID, title: String, desc: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.desc = desc
        self.isCompleted = isCompleted
        self.date = Date()
    }
}
