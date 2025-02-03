//
//  EditTaskView.swift
//  TaskManagementApp
//
//  Created by admin on 03/02/25.
//

import SwiftUI

struct EditTaskView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var task: Task
    @State private var title = ""
    @State private var dueDate = Date()
    @State private var category = "Personal"
    @State private var isCompleted = false
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
                    Toggle("Complete", isOn: $isCompleted)
                }
            }
            .navigationBarTitle("Edit Task", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                dismiss()
            },
                                trailing: Button("Update") {
                task.title = title
                task.dueDate = dueDate
                task.category = category
                task.isCompleted = isCompleted
                saveContext()
                dismiss()
            }
                .disabled(title.isEmpty)
                                )
            .onAppear {
                title = task.title ?? ""
                dueDate = task.dueDate ?? Date()
                category = task.category ?? "Personal"
                isCompleted = task.isCompleted
            }
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        }catch {
            print("Error saving context: \(error)")
        }
    }
}
