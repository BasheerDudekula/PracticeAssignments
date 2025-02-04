//
//  ContentView.swift
//  RestApi
//
//  Created by admin on 01/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var apiService = APIService()
    
    var body: some View {
        NavigationView {
            List(apiService.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title).font(.headline)
                    Text(post.body).font(.subheadline).foregroundColor(.secondary)
                    Rectangle().fill(Color.blue).frame(height: 20)
                }
            }
        }
        .navigationTitle("Posts")
        .onAppear {
            apiService.fetchPosts()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
