//
//  CustomToolBar.swift
//  CustomToolBarInPlaceOfTabBarLikeOutlook
//
//  Created by Nitin Bhatia on 23/06/25.
//

import SwiftUI

struct CustomToolBar: View {
    @Binding var isEditing: Bool
    @Binding var isTabBarVisible: Bool
    @Binding var data: [Int]
    @Binding var selectedItems: Set<Int>

    var body: some View {
        VStack {
            Divider()
            HStack {
                Button(action: {
                    withAnimation {
                        isEditing = false
                        isTabBarVisible = true
                    }
                }) {
                    Text("Cancel")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Capsule())
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        isEditing = false
                        isTabBarVisible = true
                    }
                    data.removeAll { selectedItems.contains($0) }
                    selectedItems.removeAll()
                }) {
                    Text("Delete")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.red.opacity(0.2))
                        .foregroundColor(.red)
                        .clipShape(Capsule())
                }
            }
        }
        .padding(.horizontal)
        .background(.background)
    }
}
