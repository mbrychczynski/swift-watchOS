//
//  ContentView.swift
//  ColorSpin Watch App
//
//  Created by Mateusz Brychczynski on 26/06/2023.
//

import SpriteKit
import SwiftUI

struct ContentView: View {
    @State private var rotation = 0.0
    @State private var title = "Woo"
    @StateObject var scene: GameScene = {
        let scene = GameScene()
        scene.size = CGSize(width: 300, height: 400)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.scaleMode = .resizeFill
        
        return scene
    }()
    var body: some View {
        NavigationStack {
            SpriteView(scene: scene)
                .ignoresSafeArea()
                .focusable()
                .digitalCrownRotation($rotation, from: -1_000_000_000, through: 1_000_000_000, sensitivity: .low, isContinuous: true) { _ in
                    scene.rotate(to: rotation)
                }
                .navigationTitle("Score \(scene.score)")
                .navigationBarTitleDisplayMode(.inline)
                .onTapGesture(perform: scene.reset)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
