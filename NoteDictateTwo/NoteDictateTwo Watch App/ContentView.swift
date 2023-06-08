//
//  ContentView.swift
//  NoteDictateTwo Watch App
//
//  Created by Mateusz Brychczynski on 07/06/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var notes = [Note]()
    @State private var text = ""
    @AppStorage("lineCount") var lineCount = 1
    
    var body: some View {
        NavigationStack {
            HStack {
                TextField("Add new note", text: $text)

                Button {
                    guard text.isEmpty == false else { return }

                    let note = Note(id: UUID(), text: text)
                    notes.append(note)
                    text = ""
                    save()
                } label: {
                    Image(systemName: "plus")
                        .padding()
                }
                .fixedSize()
                .tint(.blue)
            }

            List {
                ForEach(0..<notes.count, id: \.self) { i in
                    NavigationLink {
                        DetailView(index: i, note: notes[i], noteCount: notes.count)
                    } label: {
                        Text(notes[i].text)
                            .lineLimit(lineCount)
                    }
                }
                .onDelete(perform: delete)
                Button("Lines: \(lineCount)") {
                    lineCount += 1
                    
                    if lineCount == 4 {
                        lineCount = 1
                    }
                }
            }
            
//            NavigationLink {
//                CreditsView()
//            } label: {
//                Text("Credits")
//            }
            .navigationTitle("NoteDictate")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: load)
        }
    }
    
    func delete(offsets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
            save()
        }
    }
    
    func load() {
            do {
                let url = URL.documentsDirectory.appending(path: "notes")
                let data = try Data(contentsOf: url)
                notes = try JSONDecoder().decode([Note].self, from: data)
            } catch {
                // do nothing
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(notes)
                let url = URL.documentsDirectory.appending(path: "notes")
                try data.write(to: url, options: [.atomic, .completeFileProtection])
            } catch {
                print("Save failed")
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
