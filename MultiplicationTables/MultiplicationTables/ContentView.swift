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
    @State var start = 1
    @State var end = 12
    @State var quantity = QuestionQuantity.all

    @ViewBuilder
    var body: some View {
        if showingSettings {
            NewGameSettings(start: $start, end: $end, quantity: $quantity, submit: { self.showingSettings = false })
        } else {
            Text(verbatim: "I'm a game")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
