//
//  QuizViewController.swift
//  TakeItEasy
//
//  Created by Saul on 1/13/25.
//

import UIKit

class QuizViewController: UIViewController {


    @IBOutlet weak var quizInfoBackdropView: UIView!
    @IBOutlet weak var quizCollectionView: UICollectionView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var quizzesCompletedLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var averageScoreLabel: UILabel!

    var quizList : [Quiz] = []
    var searchData : [Quiz] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizInfoBackdropView.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
        
        quizList.append(Quiz(title: "test1"))
        quizList.append(Quiz(title: "test2"))
        quizList.append(Quiz(title: "test3"))
        searchData = quizList
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
        cell.layer.cornerRadius = 20
        cell.quizTitle.text = searchData[indexPath.row].title
        //cell.quizImage.image = UIImage(systemName: "trash.fill")
        cell.quizBackDropView.layer.cornerRadius = 20
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
