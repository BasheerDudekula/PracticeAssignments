//
//  WorkoutHistoryView.swift
//  FitnessAppMilestone
//
//  Created by admin on 04/02/25.
//

import SwiftUI
import CoreData

struct WorkoutHistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Workout.entity(), sortDescriptors: []) private var workouts: FetchedResults<Workout>
    
    @State private var showAddView = false
    
    var body: some View {
        NavigationView {
            VStack{
                List {
                    ForEach(workouts) { workout in
                        NavigationLink(destination: EditWorkoutView(workout: workout)){
                            VStack(alignment: .leading) {
                                Text(workout.exerciseName ?? "No Name").font(.headline)
                                Text("Duration: \(workout.duration, specifier: "%.2f")minutes").font(.subheadline)
                                Text("Calories Burned: \(workout.caloriesBurned, specifier: "%.2f")minutes").font(.subheadline)
                            }
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            deleteWorkout(workout)
                        } label: {
                            Label("delete", systemImage: "trash")
                        }
                    }
                }
                .navigationTitle("Workout History")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {showAddView = true}){
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showAddView) {
                    WorkoutLogView()
                }
            }
        }
    }
    
    private func deleteWorkout(_ workout: Workout) {
        viewContext.delete(workout)
        do {
            try viewContext.save()
        }catch {
            print("Error deleting workout: \(error)")
        }
    }
}

struct WorkoutHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutHistoryView()
    }
}
