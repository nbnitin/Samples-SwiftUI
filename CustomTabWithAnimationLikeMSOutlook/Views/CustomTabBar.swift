//
//  customTabBar.swift
//  CustomToolBarInPlaceOfTabBarLikeOutlook
//
//  Created by Nitin Bhatia on 23/06/25.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            HStack {
                Spacer()
                TabBarButton(icon: "envelope.fill", text: "Mail", tab: .mail, selectedTab: $selectedTab)
                Spacer()
                TabBarButton(icon: "calendar", text: "Calendar", tab: .calendar, selectedTab: $selectedTab)
                Spacer()
                TabBarButton(icon: "magnifyingglass", text: "Search", tab: .search, selectedTab: $selectedTab)
                Spacer()
            }
            .padding(.top, 8)
            .padding(.bottom, 0)
        }
        .background(Color(UIColor.systemBackground))
        .transition(.move(edge: .bottom))
    }
}
