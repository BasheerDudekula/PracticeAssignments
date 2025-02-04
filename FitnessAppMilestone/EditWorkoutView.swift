//
//  EditWorkoutView.swift
//  FitnessAppMilestone
//
//  Created by admin on 04/02/25.
//

import SwiftUI

struct EditWorkoutView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var workout: Workout
    @State private var exerciseName = ""
    @State private var duration = ""
    @State private var caloriesBurned = ""
    
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Workout Details")) {
                    TextField("Exercise Name", text: $exerciseName)
                    TextField("Duration(minutes", text: $duration).keyboardType(.decimalPad)
                    TextField("Calories Burned", text: $caloriesBurned).keyboardType(.decimalPad)
                }
                
            }
            .navigationBarTitle("Edit Workout", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                dismiss()
            },
                                trailing: Button("Update") {
                workout.exerciseName = exerciseName
                workout.duration = Double(duration) ?? 0.0
                workout.caloriesBurned = Double(caloriesBurned) ?? 0.0
                saveContext()
                dismiss()
            }
                .disabled(exerciseName.isEmpty || duration.isEmpty || caloriesBurned.isEmpty)
            )
            .onAppear {
                exerciseName = workout.exerciseName ?? ""
                duration = workout.duration ??
                caloriesBurned = workout.caloriesBurned ??
            }
        }
    }
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("error saving context: \(error)")
        }
    }
}
