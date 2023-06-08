//
//  WatchFXApp.swift
//  WatchFX Watch App
//
//  Created by Mateusz Brychczynski on 07/06/2023.
//

import SwiftUI

@main
struct WatchFX_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                CurrenciesView()
                DefaultValuesView()
            }
        }
    }
}
