//
//  AddTaskView.swift
//  TaskManagement
//
//  Created by admin on 03/02/25.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var dueDate = Date()
    @State private var category = "Personal"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Title", text: $title)
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                    Picker("Category", selection: $category) {
                        Text("Personal").tag("Personal")
                        Text("Work").tag("Work")
                        Text("Other").tag("Other")
                    }
                }
            }
            .navigationTitle("Add Task")
            .navigationBarItems(leading: Button("Cancel") {
                dismiss()
            },
            trailing: Button("Save"){
                addTask()
                dismiss()
            }
            .disabled(title.isEmpty)
            )
        }
    }
    
    private func addTask() {
        let newTask = Task(context: viewContext)
        
        newTask.title = title
        newTask.dueDate = dueDate
        newTask.category = category
        newTask.isCompleted = false
        
        do {
            try viewContext.save()
        } catch {
            print("Error saving task: \(error)")
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
