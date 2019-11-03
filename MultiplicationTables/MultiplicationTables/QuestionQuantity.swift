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
}
