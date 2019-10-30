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
    @State private var scoreMessage = ""
    @State private var score = 0
    @State private var questionsAsked = 1

    @State private var rotations: [Double] = [0, 0, 0]
    @State private var opacities: [Double] = [1, 1, 1]
    @State private var wrongs: [CGFloat] = [0, 0, 0]

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue, .black]),
                startPoint: .top, endPoint: .bottom
            ).edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .fixedSize()

                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .fixedSize()
                }

                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Flag(country: self.countries[number])
                    }
                    .rotation3DEffect(.degrees(self.rotations[number]), axis: (x: 0, y: 1, z: 0))
                    .opacity(self.opacities[number])
                    .modifier(Shake(animatableData: self.wrongs[number]))
                }
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(
                title: Text(scoreTitle),
                message: Text(scoreMessage),
                dismissButton: .default(Text("\(gameOver ? "Restart" : "Continue")")) {
                    self.askQuestion()
                })
        }
    }

    func flagTapped(_ index: Int) {
        withAnimation(.easeOut) {
            for i in 0..<3 {
                if i != correctAnswer {
                    opacities[i] = 0.25
                } else {
                    opacities[i] = 1
                }
            }
        }

        if index == correctAnswer {
            withAnimation(.default) {
                rotations[index] += 360
            }
            score += 1
            scoreTitle = "👍"
            scoreMessage = "Correct!\n"
        } else {
            withAnimation(.default) {
                wrongs[index] += 1
            }
            scoreTitle = "🙅‍♀️"
            scoreMessage = "Nope, that's \(countries[index]).\n"
        }

        if gameOver {
            scoreTitle = "🏁"
            scoreMessage += "Your score was \(score)/\(questionsAsked)!"
        } else {
            scoreMessage += "Your score is \(score)"
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
        withAnimation(.easeIn) {
            opacities = [1, 1, 1]
        }
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

/// Lifted from https://www.objc.io/blog/2019/10/01/swiftui-shake-animation/
struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}
