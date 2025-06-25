//
//  MailView.swift
//  CustomToolBarInPlaceOfTabBarLikeOutlook
//
//  Created by Nitin Bhatia on 23/06/25.
//

import SwiftUI

struct MailView: View {
    @Binding var isTabBarVisible: Bool
    @Binding var isEditing: Bool
    @Environment(\.editMode) private var editMode
    @Binding var selectedItems: Set<Int>
    @Binding var data: [Int]
    
    var body: some View {
        if data.isEmpty {
            ContentUnavailableView("No Data Found", systemImage: "magnifyingglass")
        } else {
            List(data, id: \.self, selection: $selectedItems) { item in
                Group {
                    if isEditing {
                        // ✅ Show plain selectable row
                        Text("Row \(item)")
                    } else {
                        // ✅ Show navigation when not editing
                        NavigationLink(destination: DetailView(item: item, isTabBarVisible: $isTabBarVisible)) {
                            Text("Row \(item)")
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .environment(\.editMode, .constant(isEditing ? .active : .inactive))
            .onAppear {
                if !isEditing {
                    selectedItems.removeAll()
                }
            }
        }
    }
}
