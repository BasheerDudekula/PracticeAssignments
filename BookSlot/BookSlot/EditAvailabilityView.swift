//
//  EditAvailabilityView.swift
//  BookSlot
//
//  Created by admin on 17/02/25.
//

import SwiftUI

struct EditAvailabilityView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var availability: InterviewAvailabilty
    @State private var date = Date()
    @State private var startTime = Date()
    @State private var endTime = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit Availability Details")) {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
                    DatePicker("End Time", selection: $endTime, displayedComponents: .hourAndMinute)
                }
            }
            .navigationBarTitle("Edit Availability", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") { dismiss() },
                trailing: Button("Save") {
                    availability.date = date
                    availability.startTime = startTime
                    availability.endTime = endTime
                    saveContext()
                    dismiss()
                }
            )
            .onAppear {
                date = availability.date ?? Date()
                startTime = availability.startTime ?? Date()
                endTime = availability.endTime ?? Date()
            }
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
