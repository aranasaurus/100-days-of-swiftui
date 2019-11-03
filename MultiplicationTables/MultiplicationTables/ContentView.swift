//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Ryan Arana on 11/2/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var showingSettings = true
    @State var max = 12
    @State var quantity = QuestionQuantity.all
    @State var previousScore: Int?

    @ViewBuilder
    var body: some View {
        if showingSettings {
            NewGameSettings(max: $max, quantity: $quantity, previousScore: $previousScore) {
                self.showingSettings = false
            }
        } else {
            Game(questionQuantity: quantity, max: max) { score in
                self.previousScore = score
                self.showingSettings = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
