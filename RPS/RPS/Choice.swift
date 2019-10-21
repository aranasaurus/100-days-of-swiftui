//
//  Choice.swift
//  RPS
//
//  Created by Ryan Arana on 10/20/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import Foundation

enum Choice: CustomStringConvertible, CaseIterable {
    case rock
    case paper
    case scissors

    var winsAgainst: [Choice] {
        switch self {
        case .rock: return [.scissors]
        case .paper: return [.rock]
        case .scissors: return [.paper]
        }
    }

    var description: String {
        switch self {
        case .rock: return "Rock"
        case .paper: return "Paper"
        case .scissors: return "Scissors"
        }
    }

    func play(against: Choice) -> PlayResult {
        guard self != against else { return .draw }
        return winsAgainst.contains(against) ? .win : .lose
    }
}

enum PlayResult: CustomStringConvertible, CaseIterable {
    case win
    case lose
    case draw

    var description: String {
        switch self {
        case .win: return "Win"
        case .lose: return "Lose"
        case .draw: return "Draw"
        }
    }
}
