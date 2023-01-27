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
    @State private var cowculatorAnimationAmount = 0.9
    @State private var buttonAnimationAmount = 1.0
    @State private var textSlideAnimationAmount = 1.0
    
    @State private var isMessageShowing = false
    @State private var isQuestionShowing = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.purple, .teal], startPoint: .topLeading, endPoint: .bottomLeading)
                    .ignoresSafeArea()
                
                VStack {
                    Section {
                        HStack {
                            TextField("enter name", text: $userName)
                                .textFieldStyle(.roundedBorder)
                                .padding()
                            Button("ok") {
                                isMessageShowing = true
                            }
                            .padding(2)
                            .buttonStyle(.bordered)
                            .background(.red)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                        }
                    } header: {
                         Text("What's your name?")
                    }
                    
                    HStack {
                        Text("🐮")
                            .font(.system(size: 100))
                            .scaleEffect(cowculatorAnimationAmount)
                            .animation(Animation.easeInOut(duration: 0.3).repeatForever(autoreverses: true), value: cowculatorAnimationAmount)
                            .onAppear {
                                cowculatorAnimationAmount = 1.0
                            }
                        
                        Text(isMessageShowing ? "Hi \(userName)! I'm your cowculator and I'm going to test your multiplication skills!" : "")
                    }
                    .padding()
                    
                    Section {
                        HStack {
                            Stepper("What table do you want to practice?", value: $userPracticeChoice, in: 2...12)
                                .labelsHidden()
                            Text("\(userPracticeChoice) times table")
                            Button("ok") {
                                isQuestionShowing = true
                            }
                            .padding(2)
                            .buttonStyle(.bordered)
                            .background(.red)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                        }
                    } header: {
                        Text("What table do you want to practice?")
                    }
                    
                    VStack {
                        Text(isQuestionShowing ? "What is..." : "")
                            .padding(5)
                        Text(isQuestionShowing ? "\(multiplicand) ✖️ \(multiplier) ⁉️" : "")
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
                            Button("Go!") {
                                
                            }
                            .padding(10)
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
                            .padding()
                        }
                    }
                    .padding()
                    .border(.black, width: 3)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
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
