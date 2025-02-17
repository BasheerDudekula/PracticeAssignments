//
//  DashboardView.swift
//  BookSlot
//
//  Created by admin on 15/02/25.
//


import SwiftUI
import CoreData

struct DashboardView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var user: User
    
    @State private var showAddAvailabilityView = false
    @State private var availabilityToEdit: InterviewAvailabilty?
    
    // Fetch availabilities directly using a FetchRequest (Optional improvement)
    @FetchRequest(
        entity: InterviewAvailabilty.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \InterviewAvailabilty.date, ascending: true)]
    ) var availabilities: FetchedResults<InterviewAvailabilty>
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome, \(user.name ?? "User")")
                    .font(.title)
                    .padding()
                
                List {
                    // Use fetched availabilities instead of manually accessing user.availabilities
                    ForEach(availabilities, id: \.id) { availability in
                        VStack(alignment: .leading) {
                            Text("Date: \(availability.date ?? Date(), formatter: dateFormatter)")
                            Text("Start Time: \(availability.startTime ?? Date(), formatter: timeFormatter)")
                            Text("End Time: \(availability.endTime ?? Date(), formatter: timeFormatter)")
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                deleteAvailability(availability)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .onTapGesture {
                            availabilityToEdit = availability
                        }
                    }
                }
                .onAppear {
                    // Debugging to ensure availabilities are loaded
                    print("Availabilities count: \(availabilities.count)")
                }
            }
            .navigationTitle("Dashboard")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddAvailabilityView = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddAvailabilityView) {
                InterviewAvailabilityView(user: user)
                    .onDisappear {
                        // Refresh or reload availabilities after adding
                        print("Returning from Add Availability view")
                    }
            }
            .sheet(item: $availabilityToEdit) { availability in
                EditAvailabilityView(availability: availability)
            }
        }
    }
    
    private func deleteAvailability(_ availability: InterviewAvailabilty) {
        viewContext.delete(availability)
        do {
            try viewContext.save()
            print("Deleted availability!")
        } catch {
            print("Error deleting availability: \(error)")
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
}

