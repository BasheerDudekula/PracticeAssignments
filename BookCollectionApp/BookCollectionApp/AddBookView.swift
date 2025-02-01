//
//  AddBookView.swift
//  BookCollectionApp
//
//  Created by admin on 01/02/25.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
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
            .navigationBarTitle("Add New Book", displayMode: .inline)
            .navigationBarItems(leading:Button("Cancel") {
                dismiss()
            },
            trailing: Button("Save") {
               addBook()
                dismiss()
            }
            )
        }
    }
    
    private func addBook() {
        let newBook = Book(context: viewContext)
        
        newBook.title = title
        newBook.author = author
        newBook.genre = genre
        newBook.isRead = isRead
        newBook.date = Date()
        
        do {
            try viewContext.save()
        } catch {
            print("Error saving book: \(error)")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
