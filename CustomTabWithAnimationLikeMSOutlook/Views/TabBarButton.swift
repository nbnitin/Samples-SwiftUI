//
//  TabBarButton.swift
//  CustomToolBarInPlaceOfTabBarLikeOutlook
//
//  Created by Nitin Bhatia on 23/06/25.
//

import SwiftUI

struct TabBarButton: View {
    let icon: String
    let text: String
    let tab: Tab
    @Binding var selectedTab: Tab
    
    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack {
                Image(systemName: icon)
                    .font(.system(size: 24))
                Text(text)
                    .font(.caption)
            }
            .foregroundColor(selectedTab == tab ? .accentColor : .gray)
        }
    }
}

