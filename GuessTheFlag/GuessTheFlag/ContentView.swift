//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ryan Arana on 10/13/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = [
        "Estonia",
        "France",
        "Germany",
        "Ireland",
        "Italy",
        "Nigeria",
        "Poland",
        "Russia",
        "Spain",
        "UK",
        "US"
    ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questionsAsked = 1

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue, .black]),
                startPoint: .top, endPoint: .bottom
            ).edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                Spacer()
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)

                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .fixedSize()
                }

                Spacer()

                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(
                title: Text(scoreTitle),
                message: Text(gameOver ?
                    "Your score was \(score)/\(questionsAsked)!" :
                    "Your score is \(score)"
                ),
                dismissButton: .default(Text("\(gameOver ? "Restart" : "Continue")")) {
                    self.askQuestion()
                })
        }
    }

    func flagTapped(_ index: Int) {
        if index == correctAnswer {
            score += 1
            scoreTitle = "👍"
        } else {
            scoreTitle = "🙅‍♀️"
        }

        if gameOver {
            scoreTitle = "Good Game!"
        }

        showingScore = true
    }

    var gameOver: Bool { return questionsAsked == 10 }

    func askQuestion() {
        if gameOver {
            reset()
        }
        questionsAsked += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }

    func reset() {
        questionsAsked = 0
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
