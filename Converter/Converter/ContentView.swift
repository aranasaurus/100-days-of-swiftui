//
//  ContentView.swift
//  Converter
//
//  Created by Ryan Arana on 10/12/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView {
            VStack {
                Spacer()
                TemperatureConverterView()
                Spacer()
            }
            .tabItem { Image(systemName: "thermometer") }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
