//
//  CreditsView.swift
//  NoteDictateTwo Watch App
//
//  Created by Mateusz Brychczynski on 07/06/2023.
//

import SwiftUI

struct CreditsView: View {
    var body: some View {
        VStack {
            Text("I'm Mateusz Brychczynski and I'm learning Swift with \"Hacking with Swift\" edition")
            Image(systemName: "person")
        }
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
