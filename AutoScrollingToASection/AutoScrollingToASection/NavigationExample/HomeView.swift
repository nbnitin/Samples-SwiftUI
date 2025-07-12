//
//  HomeView.swift
//  AutoScrollingToASection
//
//  Created by Nitin Bhatia on 12/07/25.
//

import SwiftUI

struct HomeView: View {
    @Binding var path : NavigationPath
    var body: some View {
        VStack {
            Button("Section 1") {
                path.append(0)
            }
            .navigationDestination(for: Int.self) { value in
                SectionList(sectionId: value, path: $path)
            }
            Button("Section 2") {
                path.append(1)
            }
            .navigationDestination(for: Int.self) { value in
                SectionList(sectionId: value, path: $path)
            }
            Button("Section 3") {
                path.append(2)
            }
            .navigationDestination(for: Int.self) { value in
                SectionList(sectionId: value, path: $path)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .navigationTitle("Available Sections")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    HomeView(path: Binding.constant(NavigationPath()))
}
