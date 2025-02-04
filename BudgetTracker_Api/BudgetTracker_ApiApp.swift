//
//  BudgetTracker_ApiApp.swift
//  BudgetTracker_Api
//
//  Created by admin on 01/02/25.
//

import SwiftUI

@main
struct BudgetTracker_ApiApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            TransactionListView(context: persistenceController.container.viewContext).environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
