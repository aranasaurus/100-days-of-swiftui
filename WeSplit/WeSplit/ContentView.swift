//
//  ContentView.swift
//  WeSplit
//
//  Created by Ryan Arana on 10/8/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var amountInput = ""
    @State private var numberOfPeopleInput = ""
    @State private var tipPercentage = 3

    let tipPercentages = [0, 10, 15, 20, 25, 30]
    var checkAmount: Double { return Double(amountInput) ?? 0 }
    var tipAmount: Double {
        let percentage = Double(tipPercentages[tipPercentage]) / 100
        return checkAmount * percentage
    }
    var total: Double { return checkAmount + tipAmount }
    var totalPerPerson: Double {
        guard let peopleCount = Double(numberOfPeopleInput), peopleCount > 0 else {
            return total
        }
        return total / peopleCount
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $amountInput)
                        .keyboardType(.decimalPad)

                    TextField("Number of people", text: $numberOfPeopleInput)
                        .keyboardType(.numberPad)
                }

                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section {
                    HStack {
                        Text("Check")
                        Spacer()
                        Text("$\(checkAmount, specifier: "%.2f")")
                    }
                    HStack {
                        Text("+ Tip")
                        Spacer()
                        Text("$\(tipAmount, specifier: "%.2f")")
                            .foregroundColor(tipPercentage == 0 ? .red : nil)
                    }
                    HStack {
                        Text("Total")
                        Spacer()
                        Text("$\(total, specifier: "%.2f")")
                            .foregroundColor(tipPercentage == 0 ? .red : nil)
                            .bold()
                    }
                }

                Section(header: Text("Each person should pay")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
