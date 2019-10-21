//
//  ScoreView.swift
//  RPS
//
//  Created by Ryan Arana on 10/19/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import SwiftUI

struct ScoreView: View {
    var score: Int
    var max: Int
    var body: some View {
        VStack {
            Text("Score").font(.title)
            HStack(alignment: .firstTextBaseline) {
                Text("\(self.score)").bold().font(.largeTitle)
                Text("/ \(self.max)")
            }
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(score: Int.random(in: 0 ... 10), max: 10)
    }
}
