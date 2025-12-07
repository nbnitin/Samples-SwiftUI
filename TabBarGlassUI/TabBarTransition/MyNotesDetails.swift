//
//  MyNotesDetails.swift
//  TaBarAccessory
//
//  Created by Nitin Bhatia on 05/12/25.
//

import SwiftUI

struct MyNotesDetails: View {
    var noteData: NotesModel
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            Text(noteData.noteDetails)
        }
        .navigationBarTitle(noteData.noteTitle)
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
                
                HStack(spacing: 20) {
                    Button {
                        
                    } label: {
                        Image(systemName: "checklist")
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "paperclip")
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil.tip.crop.circle")
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "apple.writing.tools")
                    }
                }
                .padding(.horizontal, 16)
                .buttonStyle(.plain)
            }
            
            
            ToolbarSpacer(.flexible, placement: .bottomBar)
            
            
            
//            ToolbarItem(placement: .bottomBar) {
//                
//                HStack() {
//                    Button {
//                        
//                    } label: {
//                        Image(systemName: "square.and.pencil")
//                    }
//                    
//                    
//                }
//                .padding(.horizontal, 16)
//                .buttonStyle(.plain)
//            }
            
        }
    }
}


#Preview {
    MyNotesDetails(noteData: NotesModel.getNotes()[0])
}
