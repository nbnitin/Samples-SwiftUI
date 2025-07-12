//
//  TabsView.swift
//  AutoScrollingToASection
//
//  Created by Nitin Bhatia on 12/07/25.
//

import SwiftUI

struct TabsView: View {
    @State private var selectedTab = 1
    @State private var selectedSection: Int?
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeViewForTabView(selectedTab: $selectedTab, selectedSection: $selectedSection)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(1)
            
            SectionListForTabView(sectionId: $selectedSection.wrappedValue ?? 0)
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                }
                .tag(2)
        }
    }
}

#Preview {
    TabsView()
}
