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
    @State private var userScore = 0
    
    @State private var questionAnimationAmount = 0.8
    @State private var cowculatorRotationAmount = 0.9
    @State private var buttonAnimationAmount = 1.0
    @State private var textSlideAnimationAmount = 1.0
    
    @State private var isQuestionShowing = false
    
    var numberOfQuestions = [5, 10, 20]
    @State private var selectedNumber = 5
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.purple, .teal], startPoint: .topLeading, endPoint: .bottomLeading)
                    .ignoresSafeArea()
                
                VStack {
                    TextField("Enter your name!", text: $userName)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    HStack {
                        Text("🐮")
                            .font(.system(size: 90))
                            .rotationEffect(.degrees(cowculatorRotationAmount))
                            .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: cowculatorRotationAmount)
                            .onAppear { cowculatorRotationAmount = 30.0 }
                        
                            //userName == "" ? "" :
                        Text("Hi \(userName)! I'm your cowculator and I'm going to test your multiplication skills!")
                    }
                    .padding()
                    
                    Section {
                        HStack {
                            Stepper("What table do you want to practice?", value: $userPracticeChoice, in: 2...12)
                                .labelsHidden()
                            Text("\(userPracticeChoice) times table")
                        }
                    } header: {
                        Text("What table do you want to practice?")
                    }
                    
                    Section {
                        HStack {
                            Picker("How many questions do you want?", selection: $selectedNumber) {
                                ForEach(numberOfQuestions, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                    } header: {
                        Text("How many questions do you want?")
                    }
                    .padding()
                    
                    Button("GO!") {
                            isQuestionShowing = true
                    }
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                    .buttonStyle(.bordered)
                    .background(.red)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(.red)
                            .scaleEffect(buttonAnimationAmount)
                            .opacity(2 - buttonAnimationAmount)
                            .animation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: false), value: buttonAnimationAmount)
                        )
                    .onAppear {
                        buttonAnimationAmount = 2.0
                    }
                    
                    Text(isQuestionShowing ? "What is \(multiplicand) ✖️ \(multiplier) ⁉️" : "")
                        .font(.largeTitle)
                        .scaleEffect(questionAnimationAmount)
                        .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: questionAnimationAmount)
                        .onAppear {
                            questionAnimationAmount = 1.0
                        }
                    HStack {
                        Text("Answer:")
                        TextField("enter answer", value: $userAnswer, format: .number)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                    }
                    .padding()
                        
                    HStack {
                        Spacer()
                        Text("Score: \(userScore)")
                        Spacer()
                    }
                }
                .fontWeight(.bold)
                .navigationTitle("🌈 MultiplicaFun!")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
