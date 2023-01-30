//
//  ContentView.swift
//  MultiplicaFun
//
//  Created by Mark Strijdom on 27/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var multiplicand = Int.random(in: 1...10)
    @State private var multiplier = 0
    
    //what timestable user wants to practice
    @State private var userPracticeChoice = 2
    
    @State private var userAnswer = 0
    
    //calculate the correct answer
    private var correctAnswer: Int {
        return multiplicand * multiplier
    }
    
    @State private var userName = ""
    @State private var userScore = 0
    @State private var isUserCorrect = false
    
    //how many questions user wants
    @State private var selectedNumber = 5
    @State private var questionCount = 0
    var numberOfQuestions = [5, 10, 20]
    
    //animations
    @State private var questionAnimationAmount = 0.8
    @State private var cowculatorRotationAmount = 0.9
    @State private var buttonAnimationAmount = 1.0
    @State private var textSlideAnimationAmount = 1.0
    
    //alert messages
    @State private var isQuestionShowing = false //this is to show the question on screen, not an alert
    @State private var isScoreUpdateShowing = false
    @State private var isEndGameAlertShowing = false
    
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
                            .font(.system(size: 70))
                            .rotationEffect(.degrees(cowculatorRotationAmount))
                            .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: cowculatorRotationAmount)
                            .onAppear { cowculatorRotationAmount = 30.0 }
                        
                        Text(userName == "" ? "" : "Hi \(userName)! I'm your cowculator and I'm going to test your multiplication skills!")
                            .padding()
                    }
                    .padding()
                    
                    Section {
                        HStack {
                            Stepper("What table do you want to practice?", value: $userPracticeChoice, in: 2...12)
                                .labelsHidden()
                            Text("\(userPracticeChoice) timestable")
                        }
                    } header: {
                        Text("What table do you want to practice?")
                    }
                    .padding()
                    
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
                            multiplier = userPracticeChoice
                    }
                    .fontWeight(.bold)
                    .font(.title3)
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
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Button("OK") {
                            if userAnswer == correctAnswer {
                                userScore += 1
                                isUserCorrect = true
                                isScoreUpdateShowing = true
                                questionCount += 1
                                
                                if questionCount == selectedNumber {
                                    isEndGameAlertShowing = true
                                }
                            } else {
                                isUserCorrect = false
                                isScoreUpdateShowing = true
                                questionCount += 1
                                
                                if questionCount == selectedNumber {
                                    isEndGameAlertShowing = true
                                }
                            }
                        }
                    }
                }
            }
        }
        .alert("Game Over!", isPresented: $isEndGameAlertShowing) {} message: {
            Text("🐮 You got \(userScore) of \(selectedNumber) questions correct!")
        }
        .alert("Score", isPresented: $isScoreUpdateShowing) {} message: {
            Text(isUserCorrect ? "🐮 Correct! \(multiplicand) x \(multiplier) = \(correctAnswer)" : "🐮 Wrong! \(multiplicand) x \(multiplier) = \(correctAnswer)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
