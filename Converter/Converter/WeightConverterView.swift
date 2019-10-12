//
//  WeightConverterView.swift
//  Converter
//
//  Created by Ryan Arana on 10/12/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import SwiftUI

struct WeightConverterView: View {
    @State private var input = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 1

    private var output: String {
        guard let inputWeight = Double(input) else { return "" }
        let t = Measurement(value: inputWeight, unit: units[inputUnit])
        return String(format: "%.4f", t.converted(to: units[outputUnit]).value)
    }

    private let units: [UnitMass] = [
        .pounds,
        .ounces,
        .shortTons,
        .kilograms,
        .metricTons,
        .stones
    ]

    var body: some View {
        Form {
            Section(header: Text("Input")) {
                TextField("Enter input weight", text: $input)
                    .keyboardType(.decimalPad)
                Picker("Input Units", selection: $inputUnit) {
                    ForEach(0 ..< units.count) {
                        Text(self.units[$0].symbol)
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }

            Section(header: Text("Output")) {
                Text(output)
                Picker("Output Weight", selection: $outputUnit) {
                    ForEach(0 ..< units.count) {
                        Text(self.units[$0].symbol)
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
        }
    }
}

struct WeightConverterView_Previews: PreviewProvider {
    static var previews: some View {
        WeightConverterView()
    }
}
