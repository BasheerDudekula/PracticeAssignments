//
//  NotesAppApp.swift
//  NotesApp
//
//  Created by admin on 31/01/25.
//

import SwiftUI

@main
struct NotesAppApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            NoteListView().environment(\.managedObjectContext,  persistenceController.container.viewContext)
        }
    }
}
