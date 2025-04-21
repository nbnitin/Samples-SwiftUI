//
//  NetworkMonitorApp.swift
//  NetworkMonitor
//
//  Created by Nitin Bhatia on 19/04/25.
//

import SwiftUI

@main
struct NetworkMonitorApp: App {
    @StateObject private var networkMonitor = NetworkMonitor()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.isNetworkConnected, networkMonitor.isConntected)
                .environment(\.connectionType, networkMonitor.connectionType)
        }
    }
}
