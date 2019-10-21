//
//  ContentView.swift
//  RPS
//
//  Created by Ryan Arana on 10/18/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    let maxTurns = 10
    @State var cpuChoice: Choice?
    @State var playerChoice: Choice?
    @State var desiredResult = PlayResult.allCases.randomElement()!
    @State var playResult: PlayResult?
    @State var score = 0
    @State var turnCount = 1
    @State var resultsScore = 0
    @State var showResults = false

    var body: some View {
        VStack {
            VStack {
                VStack(spacing: 16) {
                    Spacer()
                    VStack {
                        Text("Computer")
                            .font(.title)
                            .bold()
                        Text(cpuChoice?.description ?? "???")
                            .font(.largeTitle)
                    }
                    Text("vs")
                        .font(.largeTitle)
                    VStack {
                        Text("Player")
                            .font(.title)
                            .bold()
                        Text(playerChoice?.description ?? "???")
                            .font(.largeTitle)
                    }
                    Spacer()
                }
                PlayResultView(result: playResult)
            }

            Divider()

            VStack(alignment: .center, spacing: 16) {
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text("Try to ")
                    PlayResultView(result: desiredResult)
                }
                HStack {
                    Spacer()
                    Button("Rock") { self.playerChose(.rock) }
                        .disabled(playerChoice != nil)
                    Spacer()
                    Button("Paper") { self.playerChose(.paper) }
                        .disabled(playerChoice != nil)
                    Spacer()
                    Button("Scissors") { self.playerChose(.scissors) }
                        .disabled(playerChoice != nil)
                    Spacer()
                }.font(.largeTitle)
            }

            Divider()

            Spacer()
            ScoreView(score: score, max: maxTurns)
        }.alert(isPresented: $showResults, content: {
            Alert(title: Text("Good Game!"), message: Text("You got \(resultsScore) out of \(maxTurns)!"))
        })
    }

    private func playerChose(_ choice: Choice) {
        playerChoice = choice
        cpuChoice = Choice.allCases.randomElement()
        playResult = choice.play(against: cpuChoice!)
        if playResult == desiredResult {
            score += 1
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: nextTurn)
    }

    private func nextTurn() {
        turnCount += 1
        if turnCount > 10 {
            turnCount = 1
            showResults = true
            resultsScore = score
            score = 0
        }
        desiredResult = PlayResult.allCases.randomElement()!
        playResult = nil
        cpuChoice = nil
        playerChoice = nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PlayResultView: View {
    var result: PlayResult?

    var body: some View {
        Text(result?.description ?? "Waiting...")
            .foregroundColor(result == .win ? .green : result == .lose ? .red : .yellow)
            .bold()
            .font(.largeTitle)
    }
}
