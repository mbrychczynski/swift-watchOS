//
//  ContentView.swift
//  ConnectivityWatch
//  iOS
//  Created by Mateusz Brychczynski on 27/06/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var connectivity = Connectivity()
    
    var body: some View {
        VStack(spacing: 30) {
            Text(connectivity.receivedText)
            Button("Message", action: sendMessage)
            Button("Context", action: sendContext)
            Button("File", action: sendFile)
            Button("Complication", action: sendComplication)
        }
    }
    
    func sendMessage() {
        let data = ["text" : "A message from the phone"]
        connectivity.transferUserInfo(data)
    }
    
    func sendContext() {
        let data = ["text" : "Hello from the pgone"]
        connectivity.setContext(to: data)
    }
    
    func sendFile() {
        let fm = FileManager.default
        let sourceURL = URL.documentsDirectory.appending(path: "saved_file")
        
        if fm.fileExists(atPath: sourceURL.path) == false {
            try? "Hello, from a phone file".write(to: sourceURL, atomically: true, encoding: .utf8)
        }
        
        connectivity.sendFile(sourceURL)
    }
    
    func sendComplication() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
