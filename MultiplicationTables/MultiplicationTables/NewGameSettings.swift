//
//  NewGameSettings.swift
//  MultiplicationTables
//
//  Created by Ryan Arana on 11/2/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import SwiftUI

struct NewGameSettings: View {
    @Binding var max: Int
    @Binding var quantity: QuestionQuantity
    @Binding var previousScore: Int?

    var submit: () -> Void

    var body: some View {
        VStack {
            Text("Previous Score: \(previousScore ?? 0)")
                .font(.largeTitle)
                .opacity(previousScore == nil ? 0 : 1)
            Form {
                Section(header: Text("Number Range")) {
                    Stepper(value: $max, in: 2...25) {
                        Text("Up to \(max)")
                    }
                }

                Section(header: Text("How many questions?")) {
                    Picker("Question Quantity", selection: $quantity) {
                        ForEach(QuestionQuantity.allCases, id: \.self) {
                            Text($0.description).tag($0)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }

                BigGreenButton(text: "Start", action: submit)
            }
        }
    }
}

struct NewGameSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        return NewGameSettings(
            max: .constant(12),
            quantity: .constant(.ten),
            previousScore: .constant(nil)) {

        }
    }
}
