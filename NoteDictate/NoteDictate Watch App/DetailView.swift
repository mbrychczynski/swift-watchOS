//
//  DetailView.swift
//  NoteDictate Watch App
//
//  Created by Mateusz Brychczynski on 07/06/2023.
//

import SwiftUI

struct DetailView: View {
    let index: Int
    let note: Note
    let noteCount: Int
    var body: some View {
        Text(note.text)
            .navigationTitle("Note \(index + 1)/\(noteCount)")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(index: 1, note: Note(id: UUID(), text: "Example Note"), noteCount: 5)
        }
    }
}
