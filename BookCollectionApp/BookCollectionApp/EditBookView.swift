//
//  EditBookView.swift
//  BookCollectionApp
//
//  Created by admin on 01/02/25.
//

import SwiftUI

struct EditBookView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var book: Book
    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Mystery"
    @State private var isRead = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Book Details")) {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                    Picker("Genre", selection: $genre) {
                        Text("Mystery").tag("Mystery")
                        Text("Love").tag("Love")
                        Text("Emotional").tag("Emotional")
                        Text("Sci-Fi").tag("Sci-Fi")
                    }
                    Toggle("Read", isOn: $isRead)
                }
            }
            .navigationBarTitle("Edit Book", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                dismiss()
            },
            trailing: Button("Update") {
                book.title = title
                book.author = author
                book.genre = genre
                book.isRead = isRead
                saveContext()
                dismiss()
            }
                .disabled(title.isEmpty || author.isEmpty)
            ).onAppear {
                title = book.title ?? ""
                author = book.author ?? ""
                genre = book.genre ?? "Mystery"
                isRead = book.isRead
            }
        }
    }
    
    private func saveContext() {
        do{
            try viewContext.save()
        }catch {
            print("Error saving context: \(error)")
        }
    }
}
