//
//  ContentView.swift
//  MultiplicaFun
//
//  Created by Mark Strijdom on 27/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var multiplicand = 0
    @State private var multiplier = 0
    @State private var userPracticeChoice = 2
    @State private var userAnswer = 0
    @State private var userName = ""
    @State private var questionAnimationAmount = 0.5
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("What is your name?")
                    TextField("enter name", text: $userName)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                HStack {
                    Text("🐮")
                        .font(.system(size: 100))
                    Text("Hi \(userName)! I'm your cowculator and I'm going to test your skills!")
                        .fontWeight(.bold)
                }
                
                HStack {
                    Stepper("What do you want to practice?", value: $userPracticeChoice, in: 2...12)
                    Text("\(userPracticeChoice)")
                }
                .padding()
                
                VStack {
                    Text("What is...")
                    Text("\(multiplicand) ✖️ \(multiplier) ⁉️")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .scaleEffect(questionAnimationAmount)
                        .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: questionAnimationAmount)
                        .onAppear {
                            questionAnimationAmount = 1.0
                        }
                    HStack {
                        Text("Your answer:")
                        TextField("enter answer", value: $userAnswer, format: .number)
                            .textFieldStyle(.roundedBorder)
                        Button("Go!") {
                            
                        }
                        .padding()
                    }
                }
                .padding()
                .border(.black, width: 3)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
            }
            .navigationTitle("MultiplicaFun!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
