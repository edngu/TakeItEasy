//
//  QuizViewController.swift
//  TakeItEasy
//
//  Created by Saul on 1/13/25.
//

import UIKit

class QuizViewController: UIViewController {


    @IBOutlet weak var quizInfoBackdropView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        quizInfoBackdropView.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
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

extension QuizViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128, height: 128)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "quizCell", for: indexPath) as! QuizCollectionViewCell
        cell.layer.cornerRadius = 20
        //cell.quizImage.image = UIImage(systemName: "trash.fill")
        cell.quizBackDropView.layer.cornerRadius = 20
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "questionSegue", sender: nil)
    }
    
}
