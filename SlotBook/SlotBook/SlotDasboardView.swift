//
//  SlotDasboardView.swift
//  SlotBook
//
//  Created by admin on 16/02/25.
//

import SwiftUI

struct SlotDashboardView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode

    @FetchRequest(
        entity: Slot.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Slot.date, ascending: true)]
    ) var slots: FetchedResults<Slot>

    @Binding var isAuthenticated: Bool
    var selectedTechTrack: TechTrack

    @State private var newSlotDate = Date()
    @State private var editingSlot: Slot? // To track the slot being edited

    var body: some View {
        NavigationView {
            VStack {
                Text("Manage Slots for \(selectedTechTrack.name ?? "Unknown Tech Track")")
                    .font(.largeTitle)
                    .padding()

                List {
                    ForEach(slots.filter { $0.techTrack == selectedTechTrack }, id: \.self) { slot in
                        HStack {
                            Text("\(slot.date ?? Date(), formatter: dateFormatter)")
                            Spacer()
                            Button("Edit") {
                                editingSlot = slot
                                newSlotDate = slot.date ?? Date() // Set date for editing
                            }
                            .foregroundColor(.blue)

                            Button("Remove") {
                                removeSlot(slot)
                            }
                            .foregroundColor(.red)
                        }
                    }
                }

                DatePicker("Select Slot Date", selection: $newSlotDate, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()

                // Add or Update Slot based on editing state
                if editingSlot == nil {
                    Button("Add Slot") {
                        addSlot()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                } else {
                    Button("Update Slot") {
                        updateSlot()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }

                Spacer()

                Button("Logout") {
                    isAuthenticated = false // Simulate logout
                    presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(.bordered)
                .padding()
            }
            .navigationTitle("Slot Management")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Back") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }

    // Add Slot Function
    private func addSlot() {
        let newSlot = Slot(context: viewContext)
        newSlot.date = newSlotDate
        newSlot.techTrack = selectedTechTrack // Associate the new slot with the selected tech track

        saveContext()
    }

    // Update Slot Function
    private func updateSlot() {
        if let slot = editingSlot {
            slot.date = newSlotDate // Update the date of the selected slot
            saveContext()
            editingSlot = nil // Clear the editing state
        }
    }

    // Remove Slot Function
    private func removeSlot(_ slot: Slot) {
        viewContext.delete(slot)
        saveContext()
    }

    // Save Core Data Context
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving Core Data: \(error)")
        }
    }

    // Date Formatter
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}
