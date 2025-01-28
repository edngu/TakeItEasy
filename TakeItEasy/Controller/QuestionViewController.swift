//
//  QuestionViewController.swift
//  TakeItEasy
//
//  Created by Saul on 1/13/25.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var backDropView: UIView!
    @IBOutlet weak var questionButton1: UIButton!
    @IBOutlet weak var questionButton2: UIButton!
    @IBOutlet weak var questionButton3: UIButton!
    @IBOutlet weak var questionButton4: UIButton!
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    var quiz : Quiz?
    var userResponses : [Int?] = Array(repeating: nil, count: 5)
    var currentQuestionIndex = 0
    
    @IBOutlet weak var segmentSection: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backDropView.layer.cornerRadius = 30
        
        changeQuestion()
    }
    
    
    func changeQuestion() {
        
        /// If going back to an already answered question, color the previous response
        changeButtonColors(selectedButton: userResponses[currentQuestionIndex])
        
        guard let a = quiz?.getQuestions()[currentQuestionIndex].getResponseOptions() else {
            return
        }
        
        questionLabel.text = quiz?.getQuestions()[currentQuestionIndex].question
        
        questionButton1.setTitle(a[0], for: .normal)
        questionButton2.setTitle(a[1], for: .normal)
        questionButton3.setTitle(a[2], for: .normal)
        questionButton4.setTitle(a[3], for: .normal)
    }
    
    
    func changeButtonColors(selectedButton: Int?) {
        
        questionButton1.configuration?.baseBackgroundColor = .light
        questionButton2.configuration?.baseBackgroundColor = .light
        questionButton3.configuration?.baseBackgroundColor = .light
        questionButton4.configuration?.baseBackgroundColor = .light
        
        
        switch selectedButton {
            case 0:
                questionButton1.configuration?.baseBackgroundColor = .medium
            case 1:
                questionButton2.configuration?.baseBackgroundColor = .medium
            case 2:
                questionButton3.configuration?.baseBackgroundColor = .medium
            case 3:
                questionButton4.configuration?.baseBackgroundColor = .medium
            default:
                break
        }

    }
    

    @IBAction func answer1Click(_ sender: Any) {
        userResponses[currentQuestionIndex] = 0
        changeButtonColors(selectedButton: 0)
    }
    
    @IBAction func answer2Click(_ sender: Any) {
        userResponses[currentQuestionIndex] = 1
        changeButtonColors(selectedButton: 1)
    }
    
    @IBAction func answer3Click(_ sender: Any) {
        userResponses[currentQuestionIndex] = 2
        changeButtonColors(selectedButton: 2)
    }
    
    @IBAction func answer4Click(_ sender: Any) {
        userResponses[currentQuestionIndex] = 3
        changeButtonColors(selectedButton: 3)
    }
    
    @IBAction func didChangeSegment(_ sender: Any) {
        currentQuestionIndex = segmentSection.selectedSegmentIndex
        changeQuestion()
    }
    @IBAction func submit(_ sender: Any) {
        quiz?.markQuiz(userResponses: userResponses)
        if let account = GlobalData.shared.signedInAccount {
            let newCount = account.quizTakenCount!+1
            let newScore = account.quizTotalScore!+(quiz?.score ?? 0)
            let newPoints = account.points!+(quiz?.getPoints() ?? 0)
            
            DBHelper.dbhelper.updateAccountQuizResults(id: account.id!, quizTakenCount: newCount, quizTotalScore: newScore, points: newPoints)
            
            GlobalData.shared.signedInAccount?.quizTakenCount = newCount
            GlobalData.shared.signedInAccount?.quizTotalScore = newScore
            GlobalData.shared.signedInAccount?.points = newPoints
        }
        self.performSegue(withIdentifier: "resultsSegue", sender: quiz)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        if (segue.identifier == "resultsSegue") {
            let resultView = segue.destination as! ResultsViewController
            let quiz = sender as! Quiz?
            resultView.quiz = quiz
        }
    }
}
