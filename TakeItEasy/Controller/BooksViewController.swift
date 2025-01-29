//
//  BooksViewController.swift
//  TakeItEasy
//
//  Created by Saul on 1/13/25.
//

import UIKit

class BooksViewController: UIViewController {

    var booksList: [BookAPIHelper.BookModel] = []
    @IBOutlet weak var titleLabelBackDropView: UIView!
    @IBOutlet weak var username: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        username.text = GlobalData.shared.signedInAccount?.email
        
        booksList = BookAPIHelper.shared.fetchedBookData
        // Do any additional setup after loading the view.
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
}

extension BooksViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return booksList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128, height: 128)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookcell", for: indexPath) as! BookCollectionViewCell
        cell.bookTitleLabel?.text = booksList[indexPath.row].title
        
        if let thumbnailURL = booksList[indexPath.row].thumbnail_url, let thumbnail = URL(string: thumbnailURL) {
            let session = URLSession(configuration: .default)
                
            let downloadImageTask = session.dataTask(with: thumbnail) { data, response, error in
                if let error = error {
                    print("Error getting thumbnail")
                    return
                }
                    
                if let imageData = data {
                    DispatchQueue.main.async {
                        cell.bookImage.image = UIImage(data: imageData)
                    }
                }
            }
            downloadImageTask.resume()
        }
        
        cell.layer.cornerRadius = 30
        cell.bookBackdropView.layer.cornerRadius = 15
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "bookSegue", sender: booksList[indexPath.row])
    }
    
    
}
