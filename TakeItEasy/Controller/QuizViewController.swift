//
//  QuizViewController.swift
//  TakeItEasy
//
//  Created by Saul on 1/13/25.
//

import UIKit

class QuizViewController: UIViewController {


    @IBOutlet weak var quizInfoBackdropView: UIView!
    @IBOutlet weak var backDropView1: UIView!
    @IBOutlet weak var backDropView2: UIView!
    @IBOutlet weak var backDropView3: UIView!
    @IBOutlet weak var quizCollectionView: UICollectionView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var quizzesCompletedLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var averageScoreLabel: UILabel!

    var quizList : [Quiz] = []
    var searchData : [Quiz] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        username.text = GlobalData.shared.signedInAccount?.email
        //print(QuizDBHelper.shared.getAllQuizzes())
        let quizzes = QuizDBHelper.shared.getAllQuizzes()
        
        for quiz in quizzes {
            guard let t = quiz.title else {
                continue
            }
            quizList.append(Quiz(title: t, iconFileName: quiz.iconfile!, questionSet: quiz.questions!))
        }
        
        // Temporary, quiz wont show up if there is only 1 quiz
        quizList.append(Quiz(title: "test1"))
        //quizList.append(Quiz(title: "test2"))
        //quizList.append(Quiz(title: "test3"))
        
        searchData = quizList
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tabBarItem.image = UIImage(systemName: "questionmark.message")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setAccountStats()
    }
    
    func setAccountStats() {
        if let num = GlobalData.shared.signedInAccount?.quizTakenCount {
            quizzesCompletedLabel.text = String(num)
            
            if num > 0 {
                if let score = GlobalData.shared.signedInAccount?.quizTotalScore {
                    let percentage = Int(Double(score)/Double(num)/5.0*100.0)
                    averageScoreLabel.text = "\(percentage)%"
                }
            }
        }
        
        if let num = GlobalData.shared.signedInAccount?.points {
            pointsLabel.text = String(num)
        }
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        if (segue.identifier == "questionSegue") {
            let questionView = segue.destination as! QuestionViewController
            let quiz = sender as! Quiz?
            questionView.quiz = quiz
        }
    }
    
    func setupUI(){
        quizInfoBackdropView.layer.cornerRadius = 30
        backDropView1.layer.cornerRadius = 30
        backDropView2.layer.cornerRadius = 30
        backDropView3.layer.cornerRadius = 30
    }
    
}

extension QuizViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128, height: 128)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "quizCell", for: indexPath) as! QuizCollectionViewCell
        cell.layer.cornerRadius = 30
        cell.quizTitle.text = searchData[indexPath.row].title
        cell.quizBackDropView.layer.cornerRadius = 15
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchData[indexPath.row].randomizeQuestions()
        self.performSegue(withIdentifier: "questionSegue", sender: searchData[indexPath.row])
    }
    
}


extension QuizViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchData = searchText.isEmpty ? quizList : quizList.filter {
            (quiz: Quiz) -> Bool in
            return quiz.title.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        quizCollectionView.reloadData()
    }
    
}
