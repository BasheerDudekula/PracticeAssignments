//
//  NoteListView.swift
//  NotesApp
//
//  Created by admin on 31/01/25.
//

import SwiftUI
import CoreData

struct NoteListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Note.entity(), sortDescriptors: []) private var notes: FetchedResults<Note>
    
    @State private var showAddView = false
    @State private var noteToEdit: Note?
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(notes) { note in
                        NavigationLink(destination: EditNoteView(note: note)) {
                            VStack(alignment: .leading) {
                                Text(note.title ?? "Untitled").font(.headline)
                                Text(note.content ?? "").font(.subheadline)
                                    .foregroundColor(.gray)
                                Text(note.date ?? Date(),style: .date).font(.caption)
                            }
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                deleteNote(note)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .navigationTitle("All Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {showAddView = true}) {
                        Image( systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddView) {
                AddNoteView()
            }
        }
    }
    
    private func deleteNote(_ note: Note) {
        viewContext.delete(note)
        do {
            try viewContext.save()
        } catch {
            print("Error deleting note: \(error)")
        }
    }
}

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        NoteListView()
    }
}
