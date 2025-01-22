//
//  QuestionViewController.swift
//  TakeItEasy
//
//  Created by Saul on 1/13/25.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionButton1: UIButton!
    @IBOutlet weak var questionButton2: UIButton!
    @IBOutlet weak var questionButton3: UIButton!
    @IBOutlet weak var questionButton4: UIButton!
    
    var quiz : Quiz?
    var userResponses : [Int?] = Array(repeating: nil, count: 5)
    var currentQuestionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //questionButton1.titleLabel?.text = "Question 1"
        changeQuestion()
    }
    
    
    func changeQuestion() {
        
        if let userResponse = userResponses[currentQuestionIndex] {
            changeButtonColors(selectedButton: userResponse)
        }
        
        questionButton1.titleLabel?.text = quiz?.getQuestions()[currentQuestionIndex].getResponseOptions()[0]
        questionButton2.titleLabel?.text = quiz?.getQuestions()[currentQuestionIndex].getResponseOptions()[1]
        questionButton3.titleLabel?.text = quiz?.getQuestions()[currentQuestionIndex].getResponseOptions()[2]
        questionButton4.titleLabel?.text = quiz?.getQuestions()[currentQuestionIndex].getResponseOptions()[3]
    }
    
    
    func changeButtonColors(selectedButton: Int) {
        
        questionButton1.tintColor = .brown
        questionButton2.tintColor = .brown
        questionButton3.tintColor = .brown
        questionButton4.tintColor = .brown

        switch selectedButton {
            case 0:
                questionButton1.tintColor = .blue
            case 1:
                questionButton2.tintColor = .blue
            case 2:
                questionButton3.tintColor = .blue
            case 3:
                questionButton4.tintColor = .blue
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
    }
    @IBAction func submit(_ sender: Any) {
        self.performSegue(withIdentifier: "resultsSegue", sender: self)
    }
    
}
