//
//  FitnessAppMilestoneApp.swift
//  FitnessAppMilestone
//
//  Created by admin on 04/02/25.
//

import SwiftUI

@main
struct FitnessAppMilestoneApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            WorkoutHistoryView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
