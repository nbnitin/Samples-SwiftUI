//
//  TaskManagementApp.swift
//  TaskManagement
//
//  Created by Nitin Bhatia on 25/04/25.
//

import SwiftUI

@main
struct TaskManagementApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: TasksModel.self)
        }
    }
}
