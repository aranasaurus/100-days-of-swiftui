//
//  Part2ContentView.swift
//  Animations
//
//  Created by Ryan Arana on 10/27/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import SwiftUI

struct Part2ContentView: View {
    @State private var enabled = false

    var body: some View {
        Button("Tap Me") {
            self.enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? Color.blue : .red)
        .animation(nil)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        .animation(.interpolatingSpring(stiffness: 10, damping: 1))
    }
}

struct Part2ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Part2ContentView()
    }
}
