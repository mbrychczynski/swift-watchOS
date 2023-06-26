//
//  ContentView.swift
//  iMove Watch App
//
//  Created by Mateusz Brychczynski on 26/06/2023.
//

import HealthKit
import SwiftUI

struct ContentView: View {
    @StateObject var dataManager = DataManager()
    
    let activities: [(name: String, type: HKWorkoutActivityType)] = [
        ("Cycling", .cycling),
        ("Running", .running),
        ("Wheelchair", .wheelchairRunPace)
    ]
    
    @State private var selectedActivity = 0
    
    var body: some View {
        if dataManager.state == .inactive {
            VStack {
                Picker("Choose an activity", selection: $selectedActivity) {
                    ForEach(0..<activities.count, id: \.self) { index in
                        Text(activities[index].name)
                    }
                }
                
                Button("Start Workout") {
                    guard HKHealthStore.isHealthDataAvailable() else { return }
                    dataManager.activity = activities[selectedActivity].type
                    dataManager.start()
                }
            }
        } else {
            WorkoutView(dataManager: dataManager)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
