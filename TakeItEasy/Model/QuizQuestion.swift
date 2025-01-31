//
//  QuizQuestion.swift
//  TakeItEasy
//
//  Created by admin on 1/16/25.
//

import Foundation

class QuizQuestion {
    
    var question : String
    private var answer : String
    private var fillerResponses : [String]
    private var responseOptions : [String] = []
    private var answerIndex : Int = 0
    
    init(question: String, answer: String, fillerResponses: [String]) {
        self.question = question
        self.answer = answer
        self.fillerResponses = fillerResponses
        generateResponseOptions()
    }
    
    func generateResponseOptions() {
        responseOptions = []
        var nums = [Int]()
        
        for i in 0..<fillerResponses.count {
            nums.append(i)
        }
        
        for _ in 0..<3 {
            let index = Int.random(in: 0..<nums.count)
            responseOptions.append(fillerResponses[nums.remove(at: index)])
        }
        
        answerIndex = Int.random(in: 0..<4)
        responseOptions.insert(answer, at: answerIndex)
    }
    
    func getResponseOptions() -> [String] {
        return responseOptions
    }
    
    func getAnswerIndex() -> Int {
        return answerIndex
    }
    
}
