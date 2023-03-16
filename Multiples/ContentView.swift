//
//  ContentView.swift
//  Multiples
//
//  Created by Alper Koçer on 28.09.2022.
//

import SwiftUI

struct Question {
    let question: String
    let answer: Int
}

struct ContentView: View {
    @State private var multiplicationTable = 2
    @State private var numberOfQuestions = 5
    @State private var score: Int = 0
    
    @State private var isGameStarted = false
    
    @State private var submittedAnswer: Int = 0
    
    @State private var listOfQuestions = [Question]()
    @State private var listOfAnswers = [Int]()
    @State private var questionNumber = 0
    
    @FocusState private var amountIsFocused: Bool
    
    let numbersOfQuestions = [5, 10, 15]
    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    Text("Which multiplication table you want to practice?")
                    Stepper("x\(multiplicationTable)", value: $multiplicationTable, in: 2...12, step:1)
                }
                
                Section {
                    Picker("How many questions you want to answer?", selection: $numberOfQuestions) {
                        ForEach(numbersOfQuestions, id: \.self) {
                            Text($0, format: .number)
                        }
                    }

                }
                
                if isGameStarted {
                    Section {
                        HStack(spacing: 50){
                            Text(listOfQuestions[questionNumber].question)
                            TextField("Please enter your answer", value: $submittedAnswer, format: .number)
                                .keyboardType(.decimalPad)
                                .focused($amountIsFocused)
                        }
                    }
                }
            }
            .navigationTitle("Multiples")
            .toolbar{
                
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Start Game"){
                        startGame()
                    }.buttonStyle(.borderedProminent)
                }
                
                ToolbarItem(placement: .keyboard){
                    Button("Submit"){
                        changeQuestion()
                    }
                }
                
            }
        }
    }
    
    func startGame() {
        isGameStarted = true
        generateNumber()
    }
    
    func generateNumber() {
        for _ in 0..<numberOfQuestions {
            let randomNumber = Int.random(in: 1...10)
            
            let correctAnswer = multiplicationTable * randomNumber
            listOfQuestions.append(Question(question: "\(multiplicationTable) x \(randomNumber)", answer: correctAnswer))
        }
    }
    
    func changeQuestion(){
        listOfAnswers.insert(submittedAnswer, at: questionNumber)
        
        questionNumber += 1
        
        if (questionNumber == numberOfQuestions){
            isGameStarted = false
            questionNumber = 0
            amountIsFocused = false
        }
    }
    
  
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
