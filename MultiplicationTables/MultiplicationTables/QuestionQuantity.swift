//
//  QuestionQuantity.swift
//  MultiplicationTables
//
//  Created by Ryan Arana on 11/3/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import Foundation

enum QuestionQuantity: CaseIterable, CustomStringConvertible {
    case five
    case ten
    case twenty
    case all

    var description: String {
        switch self {
        case .five: return "5"
        case .ten: return "10"
        case .twenty: return "20"
        case .all: return "All"
        }
    }

    func questions(max: Int) -> [Question] {
        var possibleQuestions = [Question]()
        for a in 1...max {
            for b in 1...max {
                possibleQuestions.append(Question(number1: a, number2: b))
            }
        }
        var questions = possibleQuestions.shuffled()

        let count: Int
        switch self {
        case .five: count = 5
        case .ten: count = 10
        case .twenty: count = 20
        case .all: count = questions.count
        }

        if count > possibleQuestions.count {
            for _ in 0..<(count - possibleQuestions.count) {
                questions.append(possibleQuestions.randomElement()!)
            }
        }
        return Array(questions.prefix(count))
    }
}
