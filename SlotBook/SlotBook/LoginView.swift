//
//  LoginView.swift
//  SlotBook
//
//  Created by admin on 16/02/25.
//

import SwiftUI
import CoreData

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: User.entity(), sortDescriptors: []) private var users: FetchedResults<User>

    @State private var username = ""
    @State private var password = ""
    @State private var isAuthenticated = false
    @State private var showError = false // To track login errors

    var body: some View {
        if isAuthenticated {
            TechTrackView(isAuthenticated: $isAuthenticated) // Redirect to dashboard with binding
        } else {
            NavigationView {
                VStack {
                    Text("Login Screen")
                        .font(.largeTitle)
                        .padding()

                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    // Show error message if login fails
                    if showError {
                        Text("Invalid username or password!")
                            .foregroundColor(.red)
                    }

                    Button("Login") {
                        authenticateUser(username: username, password: password)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()

                    NavigationLink("Register", destination: RegisterView())
                        .padding()
                }
            }
        }
    }

    private func authenticateUser(username: String, password: String) {
        if let user = users.first(where: { $0.username == username && $0.password == password }) {
            // Successful login
            isAuthenticated = true
            showError = false // Clear error if login is successful
        } else {
            // Handle invalid login here
            showError = true // Show error if login fails
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
