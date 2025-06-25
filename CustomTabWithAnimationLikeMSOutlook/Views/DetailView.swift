//
//  DetailView.swift
//  CustomToolBarInPlaceOfTabBarLikeOutlook
//
//  Created by Nitin Bhatia on 23/06/25.
//

import SwiftUI

struct DetailView: View {
    let item: Int
    @Binding var isTabBarVisible: Bool
    
    var body: some View {
        Text("Detail for item \(item)")
            .navigationTitle("Detail")
            .onAppear {
                isTabBarVisible = false
            }
            .onDisappear {
                isTabBarVisible = true
            }
    }
}
