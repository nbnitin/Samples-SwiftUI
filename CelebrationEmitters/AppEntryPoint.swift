//  AppEntryPoint.swift
//  CelebrationAnimation
//
//  Created as main entry point with navigation buttons.

import SwiftUI

struct AppEntryPoint: View {
    @State private var showEmitter: Bool = true

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                Text("Demo Entry Point")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 50)

                NavigationLink(destination: CelebrationCatchUpListView()) {
                    Text("Show Catch Up List")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(12)
                }

                NavigationLink(destination: CatchUpDemoView()) {
                    Text("Show Celebration Emitter")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(12)
                }
                
                NavigationLink(destination:                 CatchUpListView()) {
                    Text("Flying Emojis Scrolling")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(12)
                }
                

                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    AppEntryPoint()
}
