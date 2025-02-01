//
//  PostView.swift
//  SampleApp
//
//  Created by admin on 30/01/25.
//

import SwiftUI
import CoreData

struct PostView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Posts.entity(), sortDescriptors: []) private var posts: FetchedResults<Posts>
    
    @State private var showAddView = false
    @State private var postToEdit: Posts?
    
    var body: some View {
        NavigationView{
            List{
                ForEach(posts) { post in
                    NavigationLink(destination: EditPostView(post: post)) {
                        HStack{
                            VStack{
                                Text(post.title ?? "No Title")
                                Text(post.desc ?? "No Contet")
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    .swipeActions {
                        Button(role: .destructive) {
                            deletePost(post)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .navigationTitle("All Posts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddView) {
                AddPostView()
            }
        }
    }
    
    private func deletePost(_ post: Posts) {
        viewContext.delete(post)
        do{
            try viewContext.save()
        } catch {
            print("Error deleting post: \(error)")
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
