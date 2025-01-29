//
//  ResultsViewController.swift
//  TakeItEasy
//
//  Created by Saul on 1/13/25.
//

import UIKit

class ResultsViewController: UIViewController {

    
    @IBOutlet weak var backdropView0: UIView!
    @IBOutlet weak var backdropView1: UIView!
    @IBOutlet weak var backdropView2: UIView!
    @IBOutlet weak var numPoints: UILabel!
    @IBOutlet weak var numWrong: UILabel!
    @IBOutlet weak var numCorrect: UILabel!
    @IBOutlet weak var username: UILabel!

    var quiz : Quiz?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setLabels()
        username.text = GlobalData.shared.signedInAccount?.email
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setupUI(){
        backdropView0.layer.cornerRadius = 30
        backdropView1.layer.cornerRadius = 30
        backdropView2.layer.cornerRadius = 30

    }
    
    
    func setLabels() {
        
        if let points = quiz?.getPoints() {
            numPoints.text = String(points)
        }
        
        if let correct = quiz?.score {
            numCorrect.text = String(correct)
            numWrong.text = String((quiz?.getQuestions().count ?? 5) - correct)
        }
        
    }

}
