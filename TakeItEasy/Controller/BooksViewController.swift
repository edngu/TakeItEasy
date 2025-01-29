//
//  BooksViewController.swift
//  TakeItEasy
//
//  Created by Saul on 1/13/25.
//

import UIKit

class BooksViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var booksList: [BookAPIHelper.BookModel] = []
    @IBOutlet weak var titleLabelBackDropView: UIView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var collectionView3: UICollectionView!
    var booksList1 : [String] = ["1","2","3","4","5","6","7","8","9","10"]
    var booksList2 : [String] = ["11","12","13","14","15","16","17","18","19","20"]
    var booksList3 : [String] = ["21","22","23","24","25","26","27","28","29","30"]
    override func viewDidLoad() {
        super.viewDidLoad()

        username.text = GlobalData.shared.signedInAccount?.email
        booksList = BookAPIHelper.shared.fetchedBookData
       
        collectionView1.delegate = self
        collectionView2.delegate = self
        collectionView3.delegate = self
        
        collectionView1.dataSource = self
        collectionView2.dataSource = self
        collectionView3.dataSource = self
        
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tabBarItem.image = UIImage(systemName: "book")

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        if (segue.identifier == "bookSegue") {
            let pageView = segue.destination as! BookPageViewController
            let book = sender as! BookAPIHelper.BookModel?
            pageView.book = book
        }
    }
    
    @IBAction func logOut(_ sender: Any) {
        
        if let vcA = self.storyboard?.instantiateViewController(withIdentifier: "logincontroller") as? LoginViewController {
            
            self.view.window?.rootViewController = vcA
            self.view.window?.makeKeyAndVisible()
        }
    
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return booksList.count
        if collectionView == self.collectionView1 {
            return booksList1.count
        } else if collectionView == self.collectionView2 {
            return booksList2.count
        } else if collectionView == self.collectionView3 {
            return booksList3.count
        }
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128, height: 128)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookcell", for: indexPath) as! BookCollectionViewCell
        //cell.bookTitleLabel?.text = booksList[indexPath.row].title
        
        
        if collectionView == self.collectionView1 {
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "bookcell1", for: indexPath) as! BookCollectionViewCell
            cell1.bookTitleLabel?.text = booksList1[indexPath.row]
            cell1.layer.cornerRadius = 30
            cell1.bookBackdropView.layer.cornerRadius = 15
            return cell1
        } else if collectionView == self.collectionView2 {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "bookcell2", for: indexPath) as! BookCollectionViewCell
            cell2.bookTitleLabel?.text = booksList2[indexPath.row]
            cell2.layer.cornerRadius = 30
            cell2.bookBackdropView.layer.cornerRadius = 15
            return cell2
        } else {
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "bookcell3", for: indexPath) as! BookCollectionViewCell
            cell3.bookTitleLabel?.text = booksList3[indexPath.row]
            cell3.layer.cornerRadius = 30
            cell3.bookBackdropView.layer.cornerRadius = 15
            return cell3
        }
        
        
        
//        if let thumbnailURL = booksList[indexPath.row].thumbnail_url, let thumbnail = URL(string: thumbnailURL) {
//            let session = URLSession(configuration: .default)
//
//            let downloadImageTask = session.dataTask(with: thumbnail) { data, response, error in
//                if let error = error {
//                    print("Error getting thumbnail")
//                    return
//                }
//
//                if let imageData = data {
//                    DispatchQueue.main.async {
//                        cell.bookImage.image = UIImage(data: imageData)
//                    }
//                }
//            }
//            downloadImageTask.resume()
//        }
        
//        cell.layer.cornerRadius = 30
//        cell.bookBackdropView.layer.cornerRadius = 15
//        
//        
//        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "bookSegue", sender: booksList[indexPath.row])
    }
    
    
}

//extension BooksViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        //return booksList.count
//        if section == 0 {
//            return booksList.count
//        } else if section == 1 {
//            return booksList.count
//        } else if section == 2 {
//            return booksList.count
//        }
//        return 0
//    }
//    
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 3
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 128, height: 128)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookcell", for: indexPath) as! BookCollectionViewCell
//        //cell.bookTitleLabel?.text = booksList[indexPath.row].title
//        
//        
//        if indexPath.section == 0 {
//            cell.bookTitleLabel?.text = booksList[indexPath.row].title
//        } else if indexPath.section == 1 {
//            cell.bookTitleLabel?.text = booksList[indexPath.row].title
//        } else if indexPath.section == 2 {
//            cell.bookTitleLabel?.text = booksList[indexPath.row].title
//        }
//        
//        
//        
////        if let thumbnailURL = booksList[indexPath.row].thumbnail_url, let thumbnail = URL(string: thumbnailURL) {
////            let session = URLSession(configuration: .default)
////                
////            let downloadImageTask = session.dataTask(with: thumbnail) { data, response, error in
////                if let error = error {
////                    print("Error getting thumbnail")
////                    return
////                }
////                    
////                if let imageData = data {
////                    DispatchQueue.main.async {
////                        cell.bookImage.image = UIImage(data: imageData)
////                    }
////                }
////            }
////            downloadImageTask.resume()
////        }
//        
//        cell.layer.cornerRadius = 30
//        cell.bookBackdropView.layer.cornerRadius = 15
//        
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "bookSegue", sender: booksList[indexPath.row])
//    }
//    
//    
//}
