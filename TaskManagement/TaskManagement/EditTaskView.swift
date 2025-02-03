//
//  EditTaskView.swift
//  TaskManagement
//
//  Created by admin on 03/02/25.
//

import SwiftUI

struct EditTaskView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var task : Task
    
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
            .navigationTitle("Edit Task")
            .navigationBarItems(leading: Button("Cancel") { dismiss()
                
            },
            trailing: Button("Save") {
                saveTask()
                dismiss()
            }
            .disabled(title.isEmpty)
            )
            .onAppear {
                title = task.title ?? ""
                dueDate = task.dueDate ?? Date()
                category = task.category ?? "Personal"
            }
        }
    }
    
    private func saveTask() {
        task.title = title
        task.dueDate = dueDate
        task.category = category
        do {
            try viewContext.save()
        } catch {
            print("Error saving task: \(error)")
        }
    }
}
