//
//  QuizViewController.swift
//  TakeItEasy
//
//  Created by Saul on 1/13/25.
//

import UIKit

class QuizViewController: UIViewController {


    @IBOutlet weak var quizInfoBackdropView: UIView!
    
    var quizList : [Quiz] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizInfoBackdropView.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
        
        quizList.append(Quiz(title: "test1"))
        quizList.append(Quiz(title: "test2"))
        quizList.append(Quiz(title: "test3"))
        
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
        return quizList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128, height: 128)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "quizCell", for: indexPath) as! QuizCollectionViewCell
        cell.layer.cornerRadius = 20
        cell.quizTitle.text = quizList[indexPath.row].title
        //cell.quizImage.image = UIImage(systemName: "trash.fill")
        cell.quizBackDropView.layer.cornerRadius = 20
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "questionSegue", sender: quizList[indexPath.row])
    }
    
}
