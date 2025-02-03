//
//  TaskRowView.swift
//  TaskManagement
//
//  Created by admin on 03/02/25.
//

import SwiftUI

struct TaskRowView: View {
    @ObservedObject var task: Task
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.title ?? "No Title").font(.headline)
                Text(task.category ?? "No Category").font(.subheadline)
                    .foregroundColor(.gray)
                Text(task.dueDate?.formatted() ?? "No Due Date").font(.caption)
            }
            Spacer()
            Image(systemName: task.isCompleted ? "checkmark.circle.fill": "circle")
                .foregroundColor(task.isCompleted ? .green: .gray)
                .onTapGesture {
                    task.isCompleted.toggle()
                    try? task.managedObjectContext?.save()
                }
        }
    }
}
