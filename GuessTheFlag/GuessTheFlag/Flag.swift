//
//  Flag.swift
//  GuessTheFlag
//
//  Created by Ryan Arana on 10/16/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import SwiftUI

struct Flag: View {
    var country: String

    var body: some View {
        Image(self.country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.white, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct Flag_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color([UIColor.black, .red, .white, .blue].randomElement()!)
                .edgesIgnoringSafeArea(.all)
            Flag(country: ["US", "UK", "Spain"].randomElement()!)
        }
    }
}
