//
//  ContentView.swift
//  RockPaperScissors Watch App
//
//  Created by Mateusz Brychczynski on 07/06/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var question = "rock"
    @State private var title = "Win!"
    
    @State private var gameOver = false
    @State private var shouldWin = true
    @State private var level = 1
    
    @State private var currentTime = Date.now
    @State private var startTime = Date.now
    
    @State var moves = ["rock", "paper", "scissors"]
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
    var time: Int {
        let difference = currentTime.timeIntervalSince(startTime)
        return Int(difference)
    }
    
    var body: some View {
        NavigationStack {
            if gameOver {
                Text("You win!")
                    .font(.largeTitle)
                Text("Your time: \(time) seconds")

                Button("Play Again") {
                    startTime = Date()
                    gameOver = false
                    level = 1
                    newLevel()
                }
                .tint(.green)
            } else {
                Image(question)
                    .resizable()
                    .scaledToFit()
                    .navigationTitle(title)
                
                Divider()
                    .padding(.vertical)
                
                HStack {
                    ForEach(moves, id: \.self) { type in
                        Button {
                            select(move: type)
                        } label: {
                            Image(type)
                                .resizable()
                                .scaledToFit()
                        }
                        .buttonStyle(.plain)
                    }
                }
                
                HStack {
                    Text("\(level)/20")
                    Spacer()
                    Text("Time: \(time)")
                }
                .padding([.top, .horizontal])
            }
        }
        .onAppear(perform: newLevel)
        .onReceive(timer) { newTime in
            guard gameOver == false else { return }
            currentTime = newTime
        }
    }
    
    func newLevel() {
        if level == 21 {
            gameOver = true
            return
        }
        
        if Bool.random() {
            title = "Win!"
            shouldWin = true
        } else {
            title = "Lose!"
            shouldWin = false
        }

//        question = moves.randomElement()!
//        moves.shuffle()
        
        var newQuestion: String
            repeat {
                newQuestion = moves.shuffled().first!
            } while newQuestion == question

            question = newQuestion
            moves.shuffle()
    }
    
    func select(move: String) {
        let solutions = [
            "rock": (win: "paper", lose: "scissors"),
            "paper": (win: "scissors", lose: "rock"),
            "scissors": (win: "rock", lose: "paper")
        ]
        
        guard let answer = solutions[question] else {
            fatalError("Unknown question: \(question)")
        }
        
        let isCorrect: Bool

        if shouldWin {
            isCorrect = move == answer.win
        } else {
            isCorrect = move == answer.lose
        }
        
        if isCorrect {
            level += 1
        } else {
            level -= 1
            if level < 1 { level = 1 }
        }

        newLevel()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
