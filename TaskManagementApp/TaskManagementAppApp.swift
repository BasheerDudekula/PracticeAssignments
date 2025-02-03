//
//  TaskManagementAppApp.swift
//  TaskManagementApp
//
//  Created by admin on 03/02/25.
//

import SwiftUI

@main
struct TaskManagementAppApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            TaskListView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
