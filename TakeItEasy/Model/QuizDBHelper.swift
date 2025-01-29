//
//  QuizDBHelper.swift
//  TakeItEasy
//
//  Created by admin on 1/28/25.
//

import Foundation
import CoreData

class QuizDBHelper {
    
    let context = QuizPersistentStorage.shared.context
    static var shared = QuizDBHelper()
    
    private init() {}
    
    func addQuiz(title: String?, iconFile: String?, questions: NSSet?) {
        let quiz = NSEntityDescription.insertNewObject(forEntityName: "CDQuiz", into: context) as? CDQuiz
        quiz?.title = title
        quiz?.iconfile = iconFile
        quiz?.questions = questions
        do {
            try context.save()
        } catch let error {
            print("Error \(error)")
        }
    }
    
    func addQuestion(question: String?, answer: String?, quiz: CDQuiz?, responses: NSSet?) {
        let q = NSEntityDescription.insertNewObject(forEntityName: "CDQuestion", into: context) as? CDQuestion
        q?.question = question
        q?.answer = answer
        q?.responses = responses
        q?.quiz = quiz
        do {
            try context.save()
        } catch let error {
            print("Error \(error)")
        }
    }
    
    func addResponse(response: String?, question: CDQuestion?) {
        let r = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        r?.response = response
        r?.question = question
        do {
            try context.save()
        } catch let error {
            print("Error \(error)")
        }
    }
    
    
    func addMathQuiz() {
        let quiz = NSEntityDescription.insertNewObject(forEntityName: "CDQuiz", into: context) as? CDQuiz
        quiz?.title = "Math"
        quiz?.iconfile = "mathquiz.png"
        
        let q1 = NSEntityDescription.insertNewObject(forEntityName: "CDQuestion", into: context) as? CDQuestion
        q1?.question = "Twice a number equals 5 times the same number plus 18. Which is the number?"
        q1?.answer = "-6"
        let q2 = NSEntityDescription.insertNewObject(forEntityName: "CDQuestion", into: context) as? CDQuestion
        q2?.question = "Two times a number, decreased by 12 equals three times the number, decreased by 15. Which is the number?"
        q2?.answer = "3"
        let q3 = NSEntityDescription.insertNewObject(forEntityName: "CDQuestion", into: context) as? CDQuestion
        q3?.question = "If a + b = 29 , b + c = 45, a + c = 44, find a + b + c = ?"
        q3?.answer = "59"
        let q4 = NSEntityDescription.insertNewObject(forEntityName: "CDQuestion", into: context) as? CDQuestion
        q4?.question = "5 + 4 = ?"
        q4?.answer = "9"
        let q5 = NSEntityDescription.insertNewObject(forEntityName: "CDQuestion", into: context) as? CDQuestion
        q5?.question = "6 * 7 = ?"
        q5?.answer = "42"
        let q6 = NSEntityDescription.insertNewObject(forEntityName: "CDQuestion", into: context) as? CDQuestion
        q6?.question = "36 + 2 = ?"
        q6?.answer = "38"
        let q7 = NSEntityDescription.insertNewObject(forEntityName: "CDQuestion", into: context) as? CDQuestion
        q7?.question = "18 - 4 = ?"
        q7?.answer = "14"
        let q8 = NSEntityDescription.insertNewObject(forEntityName: "CDQuestion", into: context) as? CDQuestion
        q8?.question = "25 + 12 - 4 = ?"
        q8?.answer = "33"
        
        
        let q1r1 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q1r1?.response = "-8"
        q1r1?.question = q1
        let q1r2 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q1r2?.response = "4"
        q1r2?.question = q1
        let q1r3 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q1r3?.response = "2"
        q1r3?.question = q1
        let q1r4 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q1r4?.response = "0"
        q1r4?.question = q1
        let q1r5 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q1r5?.response = "52"
        q1r5?.question = q1
        
        let q1set = NSSet(array: [q1r1, q1r2, q1r3, q1r4, q1r5])
        q1?.responses = q1set
        
        let q2r1 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q2r1?.response = "-8"
        q2r1?.question = q2
        let q2r2 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q2r2?.response = "4"
        q2r2?.question = q2
        let q2r3 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q2r3?.response = "2"
        q2r3?.question = q2
        let q2r4 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q2r4?.response = "7"
        q2r4?.question = q2
        let q2r5 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q2r5?.response = "21"
        q2r5?.question = q2
        
        let q2set = NSSet(array: [q2r1, q2r2, q2r3, q2r4, q2r5])
        q2?.responses = q2set
        
        let q3r1 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q3r1?.response = "-8"
        q3r1?.question = q3
        let q3r2 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q3r2?.response = "44"
        q3r2?.question = q3
        let q3r3 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q3r3?.response = "24"
        q3r3?.question = q3
        let q3r4 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q3r4?.response = "20"
        q3r4?.question = q3
        let q3r5 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q3r5?.response = "52"
        q3r5?.question = q3

        let q3set = NSSet(array: [q3r1, q3r2, q3r3, q3r4, q3r5])
        q3?.responses = q3set
        
        let q4r1 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q4r1?.response = "-12"
        q4r1?.question = q4
        let q4r2 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q4r2?.response = "24"
        q4r2?.question = q4
        let q4r3 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q4r3?.response = "62"
        q4r3?.question = q4
        let q4r4 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q4r4?.response = "10"
        q4r4?.question = q4
        let q4r5 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q4r5?.response = "12"
        q4r5?.question = q4
        
        let q4set = NSSet(array: [q4r1, q4r2, q4r3, q4r4, q4r5])
        q4?.responses = q4set
        
        let q5r1 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q5r1?.response = "18"
        q5r1?.question = q5
        let q5r2 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q5r2?.response = "74"
        q5r2?.question = q5
        let q5r3 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q5r3?.response = "74"
        q5r3?.question = q5
        let q5r4 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q5r4?.response = "71"
        q5r4?.question = q5
        let q5r5 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q5r5?.response = "52"
        q5r5?.question = q5
        
        let q5set = NSSet(array: [q5r1, q5r2, q5r3, q5r4, q5r5])
        q5?.responses = q5set
        
        let q6r1 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q6r1?.response = "-38"
        q6r1?.question = q6
        let q6r2 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q6r2?.response = "34"
        q6r2?.question = q6
        let q6r3 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q6r3?.response = "32"
        q6r3?.question = q6
        let q6r4 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q6r4?.response = "30"
        q6r4?.question = q6
        let q6r5 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q6r5?.response = "52"
        q6r5?.question = q6
        
        let q6set = NSSet(array: [q6r1, q6r2, q6r3, q6r4, q6r5])
        q6?.responses = q6set
        
        let q7r1 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q7r1?.response = "-8"
        q7r1?.question = q7
        let q7r2 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q7r2?.response = "4"
        q7r2?.question = q7
        let q7r3 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q7r3?.response = "12"
        q7r3?.question = q7
        let q7r4 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q7r4?.response = "10"
        q7r4?.question = q7
        let q7r5 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q7r5?.response = "52"
        q7r5?.question = q7
        
        let q7set = NSSet(array: [q7r1, q7r2, q7r3, q7r4, q7r5])
        q7?.responses = q7set
        
        let q8r1 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q8r1?.response = "-8"
        q8r1?.question = q8
        let q8r2 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q8r2?.response = "34"
        q8r2?.question = q8
        let q8r3 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q8r3?.response = "2"
        q8r3?.question = q8
        let q8r4 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q8r4?.response = "30"
        q8r4?.question = q8
        let q8r5 = NSEntityDescription.insertNewObject(forEntityName: "CDResponse", into: context) as? CDResponse
        q8r5?.response = "32"
        q8r5?.question = q8
        
        let q8set = NSSet(array: [q8r1, q8r2, q8r3, q8r4, q8r5])
        q8?.responses = q8set
        
        let qSet = NSSet(array: [q1,q2,q3,q4,q5,q6,q7,q8])
        quiz?.questions = qSet
        
        do {
            try context.save()
        } catch let error {
            print("Error \(error)")
        }
    }
    
    
    func addSwiftQuiz() {
        
    }
    
    func addVocabQuiz() {
        
    }
    
    
    func getAllQuizzes() -> [CDQuiz] {
        var quizzes: [CDQuiz] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDQuiz")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            quizzes = try context.fetch(fetchRequest) as! [CDQuiz]
        } catch let error {
            print("Error \(error)")
        }
        return quizzes
    }
    
}
