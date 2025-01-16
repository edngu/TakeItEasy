//
//  Quiz.swift
//  TakeItEasy
//
//  Created by admin on 1/16/25.
//

import Foundation

class Quiz {
    
    
    var title = ""
    var iconFileName = ""
    var questions : [QuizQuestion] = []
    var score : Int = 0
    
    
    init(title: String = "", iconFileName: String = "") {
        self.title = title
        self.iconFileName = iconFileName
        generateQuestions()
    }
    
    
    func generateQuestions() {
        
        switch title {
        default:
            questions.append(QuizQuestion(question: "Q1", answer: "answer", fillerResponses: ["1","2","3","4","5","6","7"]))
            questions.append(QuizQuestion(question: "Q2", answer: "answer", fillerResponses: ["1","2","3","4","5","6","7"]))
            questions.append(QuizQuestion(question: "Q3", answer: "answer", fillerResponses: ["1","2","3","4","5","6","7"]))
            questions.append(QuizQuestion(question: "Q4", answer: "answer", fillerResponses: ["1","2","3","4","5","6","7"]))
            questions.append(QuizQuestion(question: "Q5", answer: "answer", fillerResponses: ["1","2","3","4","5","6","7"]))
            questions = questions.shuffled()
        }
    }
    
    func getQuestions() -> [QuizQuestion] {
        return questions
    }
    
    
    func markQuiz(userResponses : [Int?]) -> Int {
        var i = 0
        for question in questions {
            if let response = userResponses[i] {
                score += question.getAnswerIndex() == userResponses[i] ? 1 : 0
            }
            i += 1
        }
        return score
    }
    
}
