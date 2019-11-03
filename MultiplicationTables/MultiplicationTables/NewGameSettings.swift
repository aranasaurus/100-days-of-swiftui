//
//  NewGameSettings.swift
//  MultiplicationTables
//
//  Created by Ryan Arana on 11/2/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import SwiftUI

struct NewGameSettings: View {
    @Binding var start: Int
    @Binding var end: Int
    @Binding var quantity: QuestionQuantity
    var submit: () -> Void

    var body: some View {
        Form {
            Section(header: Text("Number Range")) {
                Stepper(value: $start, in: 1...25) {
                    Text("\(start)")
                }
                Stepper(value: $end, in: 1...25) {
                    Text("\(end)")
                }
            }

            Section(header: Text("How many questions?")) {
                Picker("Question Quantity", selection: $quantity) {
                    ForEach(QuestionQuantity.allCases, id: \.self) {
                        Text($0.description).tag($0)
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }

            ZStack {
                Color.green
                Button(action: submit) {
                    Text("Start").bold().font(.title)
                }
                .foregroundColor(.white)
                .padding(10)
            }.clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

struct NewGameSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        struct Preview {
            @State var start = 1
            @State var end = 12
            @State var quantity = QuestionQuantity.ten
        }
        let prev = Preview()
        return NewGameSettings(start: prev.$start, end: prev.$end, quantity: prev.$quantity, submit: { })
    }
}
