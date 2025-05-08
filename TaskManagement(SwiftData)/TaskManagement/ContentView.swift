//
//  ContentView.swift
//  TaskManagement
//
//  Created by Nitin Bhatia on 25/04/25.
//

enum TaskMode {
    case add
    case edit
}

import SwiftUI
import SwiftData

struct TaskCardData: Identifiable, Equatable {
    var id: UUID = UUID()
    var title: String
    var description: String
}

struct ContentView: View {
    @State private var showAddTaskView: Bool = false
    @Query var taskModel: [TasksModel]
    @State var mode : TaskMode = .add
    @State var selectedTask: TasksModel?
    @State var searchText: String = ""
    @State private var isSearchActive = false
    @Environment(\.modelContext) var modelContext
    
    var filteredTasks: [TasksModel] {
        guard !searchText.isEmpty else {
            return taskModel
        }
        
        return taskModel.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
        
    }
    
    var body: some View {
        NavigationStack {
            ZStack{
                List(filteredTasks, id: \.id) {item in
                    TaskCard(item: item) {
                        delete(item)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        mode = .edit
                        selectedTask = item
                        showAddTaskView = true
                    }
                }
                .searchable(text: $searchText, isPresented:  $isSearchActive, placement: .navigationBarDrawer(displayMode: .always))
                .animation(.easeInOut, value: taskModel)
                .listRowBackground(Color.red)
                .listStyle(.grouped)
                .scrollContentBackground(.hidden)
                .listRowSeparator(.hidden)
            
            
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem {
                        Button {
                            isSearchActive.toggle()
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .tint(Color.white)
                        }
                    }
                }
                .navigationTitle("Tasks")
                .background(Color.blue.opacity(0.5))
                .overlay {
                    if taskModel.isEmpty {
                        ContentUnavailableView.search
                    }
                }
            
                FloatingAddButton(showAddTaskView: $showAddTaskView, selectedTask: $selectedTask, mode: $mode)
                
               
                  
            }
            //            .background(Color.blue.opacity(0.5))
        }
        .onAppear {
            let appearance = UINavigationBarAppearance()
//            appearance.backgroundEffect = UIBlurEffect(style: .systemThinMaterial)
            appearance.shadowColor = .clear
            appearance.backgroundColor = UIColor(Color.blue.opacity(0.5))
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    private func delete(_ task: TasksModel) {
        withAnimation(){
            modelContext.delete(task)
            try? modelContext.save()
        }
    }
}

#Preview {
    ContentView()
}
