//
//  Inbox.swift
//  TaBarAccessory
//
//  Created by Nitin Bhatia on 06/12/25.
//

import SwiftUI

struct Inbox: View {
    private let inboxData: [InboxModel] = InboxModel.getInboxData()
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            List(inboxData, id: \.id){inboxItem in
                NavigationLink {
                    InboxDetails(inboxDetils: inboxItem)
                } label: {
                    HStack(spacing: 10) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.fill)
                            .frame(width: 50, height: 50)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(inboxItem.title)
                                .fontWeight(.semibold)
                            Text(inboxItem.subtitle)
                                .fontWeight(.thin)
                        }
                    }
                }
            }
            //as with navigation I don't want to set morphing effect which comes with glass UI with write button, so giving ID here
            .toolbar(id: "WRITEACTION", content: {
                ToolbarItem(id: "WRITE",placement: .bottomBar ,content: {
                    Button {
                        
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                    
                })
            })
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }
                }
                ToolbarSpacer(.fixed, placement: .bottomBar)
                
                DefaultToolbarItem(kind: .search, placement: .bottomBar)
                
                ToolbarSpacer(.fixed, placement: .bottomBar)
            }
            .searchable(text: $searchText, placement: .toolbar)
            .navigationTitle("Inbox")
            .navigationSubtitle("Inox Updated Just Now")
        }
    }
}

#Preview {
    Inbox()
}
