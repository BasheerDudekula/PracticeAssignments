//
//  WorkoutLogView.swift
//  FitnessAppMilestone
//
//  Created by admin on 04/02/25.
//

import SwiftUI

struct WorkoutLogView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var exerciseName = ""
    @State private var duration = ""
    @State private var caloriesBurned = ""
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Workout Details")) {
                    TextField("Exercise Name", text: $exerciseName)
                    TextField("Duration(minutes", text: $duration).keyboardType(.decimalPad)
                    TextField("Calories Burned", text: $caloriesBurned).keyboardType(.decimalPad)
                }
            }
            .navigationBarTitle("Workout Log", displayMode: .inline)
            .navigationBarItems (leading: Button("Cancel") {
                dismiss()
            },
                                 trailing: Button("Save") {
                saveWorkout()
                dismiss()
            }
                .disabled(exerciseName.isEmpty || duration.isEmpty || caloriesBurned.isEmpty)
                                 )
        }
    }
    private func saveWorkout() {
        let newWorkout = Workout(context: viewContext)
        newWorkout.exerciseName = exerciseName
        newWorkout.duration = Double(duration) ?? 0.0
        newWorkout.caloriesBurned = Double(caloriesBurned) ?? 0.0
        do {
            try viewContext.save()
            
        } catch {
            print("Error saving workout: \(error)")
        }
    }
}

struct WorkoutLogView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutLogView()
    }
}
