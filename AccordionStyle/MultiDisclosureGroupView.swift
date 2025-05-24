//
//  MultiDisclosureGroupView.swift
//  Accordion
//
//  Created by Nitin Bhatia on 24/05/25.
//

import SwiftUI

struct MultiDisclosureGroupView: View {
    @State private var expandedGroup: UUID? = nil
    var sections: [SectionItem]
    var body: some View {
        
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(sections) { section in
                    DisclosureGroup(
                        isExpanded: Binding(
                            get: { expandedGroup == section.id },
                            set: { expandedGroup = $0 ? section.id : nil }
                        ),
                        content: {
                            HStack(alignment: .top) {
                                Text(section.content)
                                    .multilineTextAlignment(.leading)
                                    .foregroundStyle(Color.secondary)
                                    .frame(maxWidth: .infinity, alignment: .leading) // 🔥 Aligns to the left without Spacer
                                
                            }
                            .padding(.leading, 0) // Optional, but helps
                        },
                        label: {
                            Text(section.title)
                                .font(.headline)
                        }
                    )
                    .padding()
                    .listRowSeparator(.hidden)
                    
                    .background(RoundedRectangle(cornerRadius: 10).stroke(section.strokeColor))
                    
                }
            }
        }
        .padding()
    }
    
}

#Preview {
    MultiDisclosureGroupView(sections: SectionItem.createDataSource())
}
