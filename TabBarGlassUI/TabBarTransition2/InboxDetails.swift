//
//  InboxDetails.swift
//  TaBarAccessory
//
//  Created by Nitin Bhatia on 06/12/25.
//

import SwiftUI

struct InboxDetails: View {
    var inboxDetils: InboxModel
    
    var body: some View {
        VStack {
            Text(inboxDetils.subtitle)
        }
        .navigationTitle(inboxDetils.title)
        .toolbar(id: "WRITEACTION", content: {
            ToolbarItem(id: "WRITE",placement: .bottomBar ,content: {
                Button {
                    
                } label: {
                    Image(systemName: "square.and.pencil")
                }
                
            })
        })
        .toolbar{
            ToolbarItem(placement: .bottomBar) {
                HStack(spacing: 16) {
                    Button {
                        
                    } label: {
                        Image(systemName: "trash")
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "folder")
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "arrowshape.turn.up.forward.fill")
                    }
                }
                .padding(.horizontal, 5)
                .buttonStyle(.plain)
            }
            ToolbarSpacer(.flexible, placement: .bottomBar)
        }
    }
}


#Preview {
    InboxDetails(inboxDetils: InboxModel.getInboxData()[0])
}
