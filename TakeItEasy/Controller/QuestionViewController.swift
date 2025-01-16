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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //questionButton1.titleLabel?.text = "Question 1"
        
        questionButton1.titleLabel?.text = quiz?.getQuestions()[0].getResponseOptions()[0]
        questionButton2.titleLabel?.text = quiz?.getQuestions()[0].getResponseOptions()[1]
        questionButton3.titleLabel?.text = quiz?.getQuestions()[0].getResponseOptions()[2]
        questionButton4.titleLabel?.text = quiz?.getQuestions()[0].getResponseOptions()[3]
    }
    

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func answer1Click(_ sender: Any) {
        self.performSegue(withIdentifier: "resultsSegue", sender: self)
    }
    
    @IBAction func answer2Click(_ sender: Any) {
    }
    
    @IBAction func answer3Click(_ sender: Any) {
    }
    
    @IBAction func answer4Click(_ sender: Any) {
    }
    
    
    
}
