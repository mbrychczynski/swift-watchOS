//
//  ComplicationBundle.swift
//  Complication
//
//  Created by Mateusz Brychczynski on 26/06/2023.
//

import WidgetKit
import SwiftUI

@main
struct ComplicationBundle: WidgetBundle {
    var body: some Widget {
        Complication()
        ComplicationLiveActivity()
    }
}
