//
//  NotesModel.swift
//  TaBarAccessory
//
//  Created by Nitin Bhatia on 05/12/25.
//

import Foundation

struct NotesModel: Identifiable {
    var id: UUID = UUID()
    var noteTitle: String
    var noteDetails: String
    
    init(noteTitle: String, noteDetails: String) {
        self.noteTitle = noteTitle
        self.noteDetails = noteDetails
    }
    
    static func getNotes() -> [NotesModel] {
        return [
            NotesModel(noteTitle: "Note 1", noteDetails: "Details 1"),
            NotesModel(noteTitle: "Note 2", noteDetails: "Details 2"),
            NotesModel(noteTitle: "Note 3", noteDetails: "Details 3"),
            NotesModel(noteTitle: "Note 4", noteDetails: "Details 4"),
            NotesModel(noteTitle: "Note 5", noteDetails: "Details 5"),
            NotesModel(noteTitle: "Note 6", noteDetails: "Details 6"),
        ]
    }
}
