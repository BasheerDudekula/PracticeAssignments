//
//  BudgetTracker2App.swift
//  BudgetTracker2
//
//  Created by admin on 30/01/25.
//

import SwiftUI

@main
struct BudgetTracker2App: App {
    let persistentController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            TransactionListView().environment(\.managedObjectContext, persistentController.container.viewContext)
        }
    }
}
