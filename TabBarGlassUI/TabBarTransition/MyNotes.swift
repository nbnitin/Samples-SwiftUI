
//
//  MyNotes.swift
//  TaBarAccessory
//
//  Created by Nitin Bhatia on 05/12/25.
//

import SwiftUI

struct MyNotes: View {
    @State private var searchText: String = ""
    private var notesData: [NotesModel] = NotesModel.getNotes()
    var body: some View {
        NavigationStack {
            List(notesData, id: \.id) {noteData in
                NavigationLink {
                    MyNotesDetails(noteData: noteData)
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(noteData.noteTitle)
                            .fontWeight(.semibold)
                        Text(noteData.noteDetails)
                            .fontWeight(.thin)
                    }
                }
            }
            .navigationTitle("My Notes")
            .navigationSubtitle("\(notesData.count) Notes")
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
                DefaultToolbarItem(kind: .search, placement: .bottomBar)
                
                ToolbarSpacer(.fixed, placement: .bottomBar)
                
//                ToolbarItem(placement: .bottomBar) {
//                    Button {
//                        
//                    } label: {
//                        Image(systemName: "square.and.pencil")
//                    }
//                }
                
                
            }
            
            .searchable(text: $searchText)
//            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
    
    }
}


#Preview {
    MyNotes()
}
