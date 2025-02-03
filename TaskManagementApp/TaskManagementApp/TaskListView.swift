//
//  TaskListView.swift
//  TaskManagementApp
//
//  Created by admin on 03/02/25.
//

import SwiftUI
import CoreData

struct TaskListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity:Task.entity(),sortDescriptors: []) private var tasks: FetchedResults<Task>
    
    @State private var showAddView = false
    @State private var taskToEdit : Task?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tasks) { task in
                    NavigationLink(destination: EditTaskView(task: task)) {
                        VStack(alignment: .leading) {
                            Text(task.title ?? "Untitled").font(.headline)
                            Text(task.dueDate?.formatted() ?? "No Date").font(.subheadline).foregroundColor(.gray)
                            Text("Category:\(task.category ?? "No Category")").font(.caption)
                            Text(task.isCompleted ? "Completed": "Not Completed").font(.caption)
                                .foregroundColor(task.isCompleted ? .green: .red)
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            deleteTask(task)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .navigationTitle("All Tasks")
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
        }
    }
    private func deleteTask(_ task : Task) {
        viewContext.delete(task)
        do{
            try viewContext.save()
        } catch {
           print ("Error deleting task: \(error)")
            
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
