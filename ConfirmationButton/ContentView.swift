//
//  ContentView.swift
//  ConfirmationButton
//
//  Created by Nitin Bhatia on 10/01/26.
//

import SwiftUI



struct ContentView: View {
    @State private var editMode: EditMode = .inactive
    @State private var wantToDelete = false
    @State private var selection: Set<Message.ID> = []
    @State private var searchText: String = ""
    @State private var messages = SAMPLE_MESSAGES
    
    var body: some View {
        NavigationStack {
            List(messages, selection: $selection) { message in
                HStack(spacing: 12) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.gray)
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(message.sender)
                                .font(.title2)
                                .foregroundStyle(.black.opacity(0.7))
                            Text(message.time)
                                .fontWeight(.light)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        Text(message.preview)
                            .lineLimit(1)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                    
                }
            }
            .environment(\.editMode, $editMode)
            
            
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if editMode == .inactive {
                        Menu {
                            Button {
                                toggleEditMode()
                            } label: {
                                Label("Select Messages", systemImage: "checkmark")
                            }
                            
                        } label: {
                            Label("Edit", systemImage: "")
                        }
                    } else {
                        Button("Done") {
                            toggleEditMode()
                        }
                    }
                }
            }
            
            .toolbar {
                if editMode == .inactive {
                    DefaultToolbarItem(kind: .search, placement: .bottomBar)
                }
                ToolbarSpacer(placement: .bottomBar)
                
                if !selection.isEmpty {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Delete") {
                            wantToDelete = true
                        }
                        
                        .confirmationDialog(
                            "Are You Sure?",
                            isPresented: $wantToDelete
                        ) {
                            Button("Delete", role: .destructive) {
                                handleDelete()
                            }
                            
                            Button("Cancel") {
                                exitEditMode()
                            }
                            
                        }
                        message: {
                            Text("This action cannot be undone.")
                        }
                    }
                }
            }
            
            .navigationTitle("Messages")
            .navigationBarTitleDisplayMode(.automatic)
        }
        .searchable(text: $searchText, placement: .toolbar)
    }
    
    // MARK: - Actions
    
    private func toggleEditMode() {
        withAnimation {
            editMode = editMode == .active ? .inactive : .active
            if editMode == .inactive {
                selection.removeAll()
            }
        }
    }
    
    private func handleDelete() {
        selection.removeAll()
        exitEditMode()
    }
    
    private func exitEditMode() {
        wantToDelete = false
        editMode = .inactive
    }
}
#Preview {
    ContentView()
}
