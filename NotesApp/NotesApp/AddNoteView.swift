//
//  AddNoteView.swift
//  NotesApp
//
//  Created by admin on 01/02/25.
//

import SwiftUI

struct AddNoteView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var content = ""
    
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Note Details")) {
                    TextField("Title", text: $title)
                    TextField("Content", text: $content)
                }
            }
            .navigationBarTitle("Add New Note", displayMode: .inline)
            .navigationBarItems( leading: Button("Cancel") {
                dismiss()
            },
            trailing: Button("Save") {
                addNote()
                dismiss()
            }
            .disabled(title.isEmpty || content.isEmpty)
            )
        }
    }
    
    private func addNote() {
        let newNote = Note(context: viewContext)
        newNote.title = title
        newNote.content = content
        newNote.date = Date()
        
        do{
            try viewContext.save()
        }catch {
            print("Error saving note: \(error)")
        }
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView()
    }
}


