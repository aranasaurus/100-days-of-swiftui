//
//  ContentView.swift
//  Animations
//
//  Created by Ryan Arana on 10/27/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount1: CGFloat = 1
    @State private var animationAmount2: CGFloat = 1
    @State private var animationAmount3: Double = 0

    var body: some View {
        VStack {
            VStack {
                Spacer()
                Button("👋") {
                }
                .font(.largeTitle)
                .padding(50)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.red)
                        .scaleEffect(animationAmount1)
                        .opacity(Double(2 - animationAmount1))
                        .animation(
                            Animation.easeOut(duration: 1)
                                .repeatForever(autoreverses: false)
                        )
                )
                Spacer()
            }
            Divider()
            VStack {
                Spacer()
                
                Stepper("Scale amount", value: $animationAmount2.animation(
                    Animation.easeInOut(duration: 0.3)
                        .repeatCount(3, autoreverses: true)
                ), in: 1...10)
                    .padding()
                
                Spacer()
                
                Button("Reset") {
                    self.animationAmount2 = 1
                }
                .padding(40)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .scaleEffect(animationAmount2)

                Spacer()
            }
            Divider()
            VStack {
                Spacer()

                Button("Tap Me") {
                    withAnimation(.interpolatingSpring(stiffness: 100, damping: 10)) {
                        self.animationAmount3 += 360
                    }
                }
                .padding(50)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .rotation3DEffect(.degrees(animationAmount3), axis: (x: 0, y: 1, z: 0))

                Spacer()
            }
        }.onAppear {
            self.animationAmount1 = 2
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
