//
//  ContentView.swift
//  PullToRefershCustom
//
//  Created by Nitin Bhatia on 06/08/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader {
            let safeAreaInset = $0.safeAreaInsets
            
            NavigationStack {
                PullToRefershScrollView(
                    actionTopPadding: safeAreaInset.top + 35,
                    leadingAction: .init(symbol: "plus", action: {
                        print("Add new tab")
                    }),
                    
                    centerAction: .init(symbol: "arrow.clockwise", action: {
                        print("Refresh")
                    }),
                    trailingAction: .init(symbol: "xmark", action: {
                        print("Close Tab")
                    })) {
                        DummyView()
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Home")
            }
        }
    }
    
    //Dummy View
    
    @ViewBuilder
    func DummyView() -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
            ForEach(1...50, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 25)
                    .fill(.red.gradient)
                    .frame(height: 160)
                    .overlay(alignment: .topLeading) {
                        VStack(alignment: .leading, spacing: 6) {
                            Circle()
                                .fill(.bar)
                                .frame(width: 45, height: 45)
                                .padding(.bottom, 5)
                            Capsule()
                                .fill(.bar)
                                .frame(width: 100, height: 5)
                            Capsule()
                                .fill(.bar)
                                .frame(width: 80, height: 5)
                            Capsule()
                                .fill(.bar)
                                .frame(width: 40, height: 5)
                        }
                        .padding(16)
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
