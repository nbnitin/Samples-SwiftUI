//
//  FloatingAddButton.swift
//  TaskManagement
//
//  Created by Nitin Bhatia on 08/05/25.
//

import SwiftUI


struct FloatingAddButton: View {
    @Binding var showAddTaskView: Bool
    @State var note: String = ""
    @Binding var selectedTask: TasksModel?
    @Binding var mode : TaskMode
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack(alignment: .trailing) {
            Spacer()
            HStack{
                Spacer()
                Button {
                    showAddTaskView.toggle()
                } label: {
                    Image(systemName: "note.text.badge.plus")
                        .foregroundStyle(.white)
                }
                .frame(width: 50, height: 50)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .shadow(radius: 5)
                .padding()
            }
        }
        .onChange(of: selectedTask) { oldValue, newTask in
            note = newTask?.title ?? ""
        }
        .sheet(isPresented: $showAddTaskView) {
            AddNoteView(noteText: $note, mode: $mode) {
                if mode == .add {
                    let taskModel = TasksModel(id: UUID(), title: note, desc: "")
                    SwiftDataHandler.insertData(using: modelContext, data: taskModel)
                } else {
                    try? SwiftDataHandler.update(using: modelContext, model: selectedTask!) { task in
                        task.title = note
                        task.date = Date()
                    }
                }
            }
            .presentationCornerRadius(20)
            .presentationDetents([.fraction(0.3)])
            //                .presentationDetents([.height(240)])
            .interactiveDismissDisabled(true)
        }
    }
}

