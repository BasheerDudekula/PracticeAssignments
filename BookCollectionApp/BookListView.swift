//
//  BookListView.swift
//  BookCollectionApp
//
//  Created by admin on 01/02/25.
//

import SwiftUI
import CoreData

struct BookListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) private var books: FetchedResults<Book>
    
    @State private var showAddView = false
    @State private var showReadBooks = false
    @State private var bookToEdit: Book?
    
    var body: some View {
        NavigationView {
            VStack {
                Toggle("Show Read Books", isOn: $showReadBooks).padding()
                
                List {
                    ForEach(books.filter{showReadBooks ? $0.isRead: true}) { book in
                        NavigationLink(destination: EditBookView(book: book)) {
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Untitled").font(.headline)
                                Text("Author: \(book.author ?? "Unknown")").font(.subheadline)
                                Text("Genre: \(book.genre ?? "Unknown")").font(.caption)
                                Text(book.isRead ? "Read": "Not Read").font(.caption)
                                    .foregroundColor(book.isRead ? .green: .red)
                                Text(book.date ?? Date(), style: .date).font(.caption)
                            }
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                deleteBook(book)
                            }label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .navigationTitle("My Library")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddView = true}) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddView) {
                AddBookView()
            }
        }
    }
    
    private func deleteBook(_ book: Book) {
        viewContext.delete(book)
        do{
            try viewContext.save()
        } catch {
            print("Error deleting book: \(error)")
        }
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}
