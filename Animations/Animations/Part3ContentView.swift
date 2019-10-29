//
//  Part3ContentView.swift
//  Animations
//
//  Created by Ryan Arana on 10/29/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import SwiftUI

struct Part3ContentView: View {
    @State private var cardDragAmount = CGSize.zero

    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var lettersDragAmount = CGSize.zero

    var body: some View {
        VStack {
            Spacer()
            
            LinearGradient(gradient: Gradient(colors: [.yellow, .red]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .frame(width: 300, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(cardDragAmount)
                .gesture(
                    DragGesture()
                        .onChanged { self.cardDragAmount = $0.translation }
                        .onEnded { _ in
                            withAnimation(.spring()) {
                                self.cardDragAmount = .zero
                            }
                    }
                )
                .animation(.spring())

            Spacer()

            HStack(spacing: 0) {
                ForEach(0 ..< letters.count) { index in
                    Text(String(self.letters[index]))
                        .padding(5)
                        .font(.title)
                        .background(self.enabled ? Color.blue : .red)
                        .offset(self.lettersDragAmount)
                        .animation(Animation.default.delay(Double(index) / 20))
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { self.lettersDragAmount = $0.translation }
                    .onEnded { _ in
                        self.lettersDragAmount = .zero
                        self.enabled.toggle()
                    }
            )

            Spacer()
        }
    }
}

struct Part3ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Part3ContentView()
    }
}
