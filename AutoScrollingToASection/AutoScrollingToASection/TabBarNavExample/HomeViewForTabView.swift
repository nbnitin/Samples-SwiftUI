//
//  HomeView.swift
//  AutoScrollingToASection
//
//  Created by Nitin Bhatia on 12/07/25.
//

import SwiftUI

struct HomeViewForTabView: View {
    @State private var path = NavigationPath()
    @Binding var selectedTab: Int
    @Binding var selectedSection: Int?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button("Section 1") {
                    path.append(0)
                    selectedTab = 2
                    selectedSection = 0
                }
                Button("Section 2") {
                    selectedTab = 2
                    selectedSection = 1
                }
                Button("Section 3") {
                    selectedTab = 2
                    selectedSection = 2
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationTitle("Available Sections")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HomeViewForTabView(selectedTab: Binding.constant(0), selectedSection: Binding.constant(0))
}
