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
    var potentialQuestions : [QuizQuestion] = []
    
    private var pointsMultiplier = 1000
    
    init(title: String = "", iconFileName: String = "") {
        self.title = title
        self.iconFileName = iconFileName
        generateQuestions()
    }
    
    init(title: String = "", iconFileName: String = "", questionSet : NSSet) {
        
        var qArray : [QuizQuestion] = []
        for que in questionSet {
            let q = que as! CDQuestion
            
            var filler : [String] = []
            for resp in q.responses! {
                let r = resp as! CDResponse
                filler.append(r.response!)
            }
                            
            let question = QuizQuestion(question: q.question!, answer: q.answer!, fillerResponses: filler)
                                
            qArray.append(question)
        }
        
        
        self.title = title
        self.iconFileName = iconFileName
        self.potentialQuestions = qArray
        
        randomizeQuestions()
    }
    

    func randomizeQuestions() {
        questions = potentialQuestions
        
        while questions.count > 5 {
            let i = Int.random(in: 0..<questions.count)
            questions.remove(at: i)
        }
        
        for q in questions {
            q.generateResponseOptions()
        }
        
        questions = questions.shuffled()
        
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
    
    
    func markQuiz(userResponses : [Int?]) {
        score = 0
        var i = 0
        for question in questions {
            if let response = userResponses[i] {
                score += question.getAnswerIndex() == response ? 1 : 0
            }
            i += 1
        }
    }
    
    func getPoints() -> Int {
        return score * pointsMultiplier
    }
    
}
