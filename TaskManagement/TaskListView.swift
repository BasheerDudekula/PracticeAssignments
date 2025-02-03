//
//  TaskListView.swift
//  TaskManagement
//
//  Created by admin on 03/02/25.
//

import SwiftUI
import CoreData

struct TaskListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Task.entity(), sortDescriptors: []) private var tasks: FetchedResults<Task>
    
    @State private var showAddView = false
    @State private var taskToEdit: Task?
    @State private var showOnlyCompleted = false
    
    var body: some View {
        NavigationView {
            VStack {
                Toggle("Show Only Completed", isOn: $showOnlyCompleted).padding(.horizontal)
                
                List{
                    ForEach(filteredTasks) { task in
                        TaskRowView(task: task).onTapGesture {
                            taskToEdit = task
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                deleteTask(task)
                            } label : {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {showAddView = true}) {
                        Image(systemName: "plus")
                    }
                }
            }
            
            .sheet(isPresented: $showAddView) {
                AddTaskView()
            }
            .sheet(item: $taskToEdit) {task in
                EditTaskView(task: task)
            }
        }
    }
    
    private var filteredTasks: [Task] {
        if showOnlyCompleted {
            return tasks.filter { $0.isCompleted }
        } else {
            return Array(tasks)
        }
    }
    
    private func deleteTask(_ task: Task) {
        viewContext.delete(task)
        do {
            try viewContext.save()
        } catch {
            print("Error deleting task: \(error)")
        }
    }
}


struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
