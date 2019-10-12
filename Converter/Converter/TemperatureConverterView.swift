//
//  TemperatureConverterView.swift
//  Converter
//
//  Created by Ryan Arana on 10/12/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import SwiftUI

struct TemperatureConverterView: View {
    @State private var input = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 1

    private var output: String {
        guard let inputTemp = Double(input) else { return "" }
        let t = Measurement(value: inputTemp, unit: units[inputUnit])
        return String(format: "%.1f", t.converted(to: units[outputUnit]).value)
    }

    private let units: [UnitTemperature] = [
        .fahrenheit,
        .celsius,
        .kelvin
    ]

    var body: some View {
        Form {
            Section(header: Text("Input")) {
                TextField("Enter input temperature", text: $input)
                    .keyboardType(.decimalPad)
                Picker("Input Units", selection: $inputUnit) {
                    ForEach(0 ..< units.count) {
                        Text(self.units[$0].symbol)
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }

            Section(header: Text("Output")) {
                Text(output)
                Picker("Output Units", selection: $outputUnit) {
                    ForEach(0 ..< units.count) {
                        Text(self.units[$0].symbol)
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
        }
    }
}

struct TemperatureConverterView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureConverterView()
    }
}
