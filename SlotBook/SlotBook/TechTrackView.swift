//
//  TechTrackView.swift
//  SlotBook
//
//  Created by admin on 16/02/25.
//

import SwiftUI

struct TechTrackView: View {
    @FetchRequest(
        entity: TechTrack.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \TechTrack.name, ascending: true)]
    ) var techTracks: FetchedResults<TechTrack>

    @Environment(\.managedObjectContext) private var viewContext

    @Binding var isAuthenticated: Bool // Use binding for logout

    @State private var newTechTrackName = "" // State to hold new tech track name
    @State private var showError = false // Show error if tech track name is empty

    var body: some View {
        NavigationView {
            VStack {

                List {
                    ForEach(techTracks, id: \.self) { techTrack in
                        NavigationLink(destination: SlotListView(techTrack: techTrack)) {
                            Text(techTrack.name ?? "Unknown Tech Track")
                        }
                        // Swipe actions for each tech track
                        .swipeActions {
                            Button(role: .destructive) {
                                deleteTechTrack(techTrack) // Updated to delete TechTrack
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }

                // TextField for adding new Tech Track
                TextField("Enter New Tech Track", text: $newTechTrackName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if showError {
                    Text("Tech Track name cannot be empty!")
                        .foregroundColor(.red)
                        .padding(.bottom, 10)
                }

                Button("Add Tech Track") {
                    addTechTrack() // Call function to add new tech track
                }
                .buttonStyle(.borderedProminent)
                .padding()

                Spacer()

                Button("Logout") {
                    isAuthenticated = false // Simulate logout
                }
                .buttonStyle(.bordered)
                .padding()
            }
            .navigationTitle("Tech Track Dashboard")
        }
    }

    // Add new Tech Track
    private func addTechTrack() {
        if newTechTrackName.isEmpty {
            showError = true // Show error if input is empty
        } else {
            let newTechTrack = TechTrack(context: viewContext)
            newTechTrack.name = newTechTrackName
            saveContext()
            newTechTrackName = "" // Clear input after adding
            showError = false // Clear error after successful addition
        }
    }

    // Delete Tech Track
    private func deleteTechTrack(_ techTrack: TechTrack) {
        viewContext.delete(techTrack)
        saveContext() // Save after deletion
    }

    // Save context to persist changes in Core Data
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving Core Data: \(error)")
        }
    }
}

