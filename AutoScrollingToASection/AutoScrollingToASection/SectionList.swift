//
//  SectionList.swift
//  AutoScrollingToASection
//
//  Created by Nitin Bhatia on 12/07/25.
//

import SwiftUI

struct SectionList: View {
    let sectionId: Int
    @Binding var path: NavigationPath
    
    var body: some View {
        NavigationView {
            ScrollViewReader { scroll in
                List(0...2, id: \.self) {index in
                    let uniqueId = "section-\(index)"
                    Section {
                        ForEach(0...20, id: \.self) { rowIndex in
                            Text("Section \(index) Item \(rowIndex + 1)")
                                .listRowInsets(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 16))
                                .listRowSeparatorTint(.blue)
                                .alignmentGuide(.listRowSeparatorLeading) { d in
                                    return -30 // Adjust the inset here
                                }
                        }
                        
                    } header: {
                        Text("Section Header \(index)")
                            .font(.headline)
                            .padding([.leading, .bottom, .top], 20)
                            .frame(maxWidth:.infinity, alignment: .leading)
                            .background(Color.gray.opacity(0.1))
                        
                    }
                    .listSectionSeparator(.hidden, edges: .top) // Remove top separator
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .id(uniqueId)
                    .onAppear {
                        withAnimation{
                            scroll.scrollTo("section-\(sectionId)", anchor: .topLeading)
                        }
                    }
                }
                .listStyle(.plain) //sticky header
                .listRowSpacing(20)
                .padding(.all, 0)
            }
            .navigationTitle("All Sections")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onDisappear() {
            path.removeLast()
        }
        
    }
}

#Preview {
    ContentView()
}
