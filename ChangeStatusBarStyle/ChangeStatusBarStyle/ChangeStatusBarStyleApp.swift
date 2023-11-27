//
//  ChangeStatusBarStyleApp.swift
//  ChangeStatusBarStyle
//
//  Created by Nitin Bhatia on 27/11/23.
//

import SwiftUI

@main
struct ChangeStatusBarStyleApp: App {
    var body: some Scene {
        WindowGroup {
            StatusBarView { //simply warpping  the main view  with our  custome view componenet. Now let's implement extension to update  the status bar anywhere in the app
                ContentView()
            }
        }
    }
}
