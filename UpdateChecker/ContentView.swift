//
//  ContentView.swift
//  UpdateChecker
//
//  Created by Nitin Bhatia on 01/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var updateAppInfo: UpdateCheckerManager.ReturnResult?
    @State private var forceUpdate: Bool = false //this is something we need to control by our own logic either of any config or api or add some thing in code
    
    var body: some View {
        NavigationStack {
            List {
                
            }
            .navigationTitle("App Update Checker")
        }
        .sheet(item: $updateAppInfo, content:{ info in
            AppUpdateInfo(info: info, forceUpdate: forceUpdate)
        })
        
        .task {
            //for education purpose I am using whats app app id
            if let result = await UpdateCheckerManager.shared.checkIfAppUpdateAvailable(appID: "310633997") {
                updateAppInfo = result
            } else {
                print("No Update Available")
            }
        }
    }
}

#Preview {
    ContentView()
}
