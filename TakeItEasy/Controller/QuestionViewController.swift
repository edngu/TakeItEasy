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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionButton1.titleLabel?.text = "Question 1"
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
