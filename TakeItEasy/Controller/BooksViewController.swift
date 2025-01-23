//
//  BooksViewController.swift
//  TakeItEasy
//
//  Created by Saul on 1/13/25.
//

import UIKit

class BooksViewController: UIViewController {

    var booksList: [BookAPIHelper.BookModel] = []
    @IBOutlet weak var username: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128, height: 128)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookcell", for: indexPath) as! BookCollectionViewCell
        cell.bookTitleLabel?.text = booksList[indexPath.row].title
        cell.layer.cornerRadius = 20
        cell.bookTitleLabel.layer.cornerRadius = 20
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "bookSegue", sender: booksList[indexPath.row])
    }
    
    
}
