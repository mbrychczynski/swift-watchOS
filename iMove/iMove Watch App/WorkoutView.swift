//
//  WorkoutView.swift
//  iMove Watch App
//
//  Created by Mateusz Brychczynski on 26/06/2023.
//

import SwiftUI

struct WorkoutView: View {
    enum DisplayMode {
        case distance, energy, heartRate
    }
    @State private var displayMode = DisplayMode.distance
    
    @ObservedObject var dataManager: DataManager
    
    var quantity: String {
        switch displayMode {
        case .distance:
            let amount = Measurement(value: dataManager.totalDistance / 1000, unit: UnitLength.kilometers)
            return amount.formatted(.measurement(width: .abbreviated, usage: .road))
            
        case .energy:
            let amount = Measurement(value: dataManager.totalEnergyBurned, unit: UnitEnergy.kilocalories)
            return amount.formatted(.measurement(width: .abbreviated, usage: .workout))
            
        case .heartRate:
            return "\(Int(dataManager.lastHeartRate)) BPM"
        }
    }
    
    var body: some View {
        VStack {
            Text(quantity)
                .font(.largeTitle)
                .onTapGesture(perform: changeDisplayMode)
            
            if dataManager.state == .active {
                Button("Stop", action: dataManager.pause)
            } else {
                Button("Resume", action: dataManager.resume)
                Button("End", action: dataManager.end)
            }
        }
    }
    
    func changeDisplayMode() {
            switch displayMode {
            case .distance:
                displayMode = .energy
            case .energy:
                displayMode = .heartRate
            case .heartRate:
                displayMode = .distance
            }
        }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView(dataManager: DataManager())
    }
}
