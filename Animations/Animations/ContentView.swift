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

    var body: some View {
        print(animationAmount2)

        return VStack {
            VStack {
                Spacer()
                Button("Tap Me") {
                }.padding(50)
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
