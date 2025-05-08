//
//  AddNoteView.swift
//  TaskManagement
//
//  Created by Nitin Bhatia on 25/04/25.
//

import SwiftUI

struct AddNoteView: View {
    @Binding var noteText: String
    @Binding var mode: TaskMode

    @Environment(\.dismiss) var dismiss
    var onSave: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text(mode == .add ? "Add New Task" : "Edit Task")
                .font(.title2)
                .padding(.top, 10)
            TextField("Enter note", text: $noteText)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding()
            HStack {
                Button("Cancel", action: {
                    dismiss()
                    noteText = ""
                })
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(Color.secondary)
                .foregroundStyle(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                Button(mode == .add ? "Save" : "Update", action: {
                    onSave()
                    dismiss()
                    noteText = ""
                })
                
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(noteText.isEmpty ? Color.gray.opacity(0.4) : Color.primary)
                .foregroundStyle(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .disabled(noteText.isEmpty)
            }
            .padding(10)
        }
    }
}

#Preview {
    ContentView()
//    AddNoteView()
}
