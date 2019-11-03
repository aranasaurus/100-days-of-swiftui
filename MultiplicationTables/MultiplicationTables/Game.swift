//
//  Game.swift
//  MultiplicationTables
//
//  Created by Ryan Arana on 11/3/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import SwiftUI

struct Question {
    let number1: Int
    let number2: Int

    var product: Int { return number1 * number2 }
    func check(_ answer: Int) -> Bool {
        return answer == product
    }
}

struct Game: View {
    var questionQuantity: QuestionQuantity
    var onComplete: (Int) -> Void

    private let questions: [Question]
    private var currentQuestion: Question { return questions[currentQuestionIndex] }

    @State private var answerText = ""
    @State private var score = 0
    @State private var currentQuestionIndex = 0

    init(questionQuantity: QuestionQuantity, max: Int, onComplete: @escaping (Int) -> Void) {
        self.questionQuantity = questionQuantity
        self.questions = questionQuantity.questions(max: max)
        self.onComplete = onComplete
    }

    var body: some View {
        Form {
            Section(header: Text("Score")) {
                Text("\(score) / \(questions.count)")
            }

            Section(header: Text("Question")) {
                HStack {
                    Spacer()
                    Text("\(currentQuestion.number1) x \(currentQuestion.number2)")
                        .font(.system(size: 60))
                        .bold()
                    Spacer()
                }
            }

            Section(header: Text("Answer")) {
                TextField("Answer", text: $answerText) {
                }
                .keyboardType(.numberPad)
                .padding()

                BigGreenButton(text: "Submit Answer", action: answerSubmitted)
                    .padding(8)
            }
        }
    }

    private func answerSubmitted() {
        let answer = Int(answerText)!
        if currentQuestion.check(answer) {
            score += 1
        } else {
            print("Wrong")
        }

        if currentQuestionIndex < questions.count - 1 {
            answerText = ""
            currentQuestionIndex += 1
        } else {
            onComplete(score)
        }
    }
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
        Game(questionQuantity: .all, max: 3, onComplete: { _ in })
    }
}
