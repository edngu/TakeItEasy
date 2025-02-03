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
    @IBOutlet weak var resultImage: UIImageView!
    
    var quiz : Quiz?
    
    enum ResultEmojis: String {
        case Perfect = "happy-emoji"
        case Pass = "smile-emoji"
        case Fail = "sad-emoji"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setLabels()
        setImage(numCorrect: quiz?.score)
        username.text = GlobalData.shared.signedInAccount?.email
       
    }
    
    //Pop Navigation controller view twice when hitting the back button instead of only once.
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        if parent == nil {
            if let navigationController = self.navigationController {
                var viewControllers = navigationController.viewControllers
                let viewControllersCount = viewControllers.count
                if (viewControllersCount > 1) {
                    viewControllers.remove(at: viewControllersCount - 1)
                    navigationController.setViewControllers(viewControllers, animated:false)
                }
            }
        }
    }
    
    func setImage(numCorrect: Int?) {
        guard let correct = numCorrect else {
            return
        }
        
        var imageFile : String?
        
        if correct >= 5 {
            imageFile = Bundle.main.path(forResource: ResultEmojis.Perfect.rawValue, ofType: "png")
        } else if correct >= 3 {
            imageFile = Bundle.main.path(forResource: ResultEmojis.Pass.rawValue, ofType: "png")
        } else {
            imageFile = Bundle.main.path(forResource: ResultEmojis.Fail.rawValue, ofType: "png")
        }
        
        if let image = imageFile {
            resultImage.image = UIImage(named: image)
        }

    }
    
    func setupUI(){
        backdropView0.layer.cornerRadius = 30
        backdropView1.layer.cornerRadius = 30
        backdropView2.layer.cornerRadius = 30
        self.navigationItem.backButtonTitle = "Quizzes"

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
