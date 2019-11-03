//
//  BigGreenButton.swift
//  MultiplicationTables
//
//  Created by Ryan Arana on 11/3/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import SwiftUI

struct BigGreenButton: View {
    var text: String
    var action: () -> Void

    var body: some View {
        ZStack {
            Color.green
            Button(action: action) {
                Text(text).bold().font(.title)
            }
            .foregroundColor(.white)
            .padding(10)
        }.clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct BigGreenButton_Previews: PreviewProvider {
    static var previews: some View {
        BigGreenButton(text: "Button", action: { })
    }
}
