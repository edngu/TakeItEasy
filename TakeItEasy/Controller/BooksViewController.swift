//
//  BooksViewController.swift
//  TakeItEasy
//
//  Created by Saul on 1/13/25.
//

import UIKit

class BooksViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    //var booksList: [BookAPIHelper.BookModel] = []
    @IBOutlet weak var titleLabelBackDropView: UIView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var collectionView3: UICollectionView!
    
    var booksList1 : [BookAPIHelper.BookModel] = []
    var booksList2 : [BookAPIHelper.BookModel] = []
    var booksList3 : [BookAPIHelper.BookModel] = []
    var booklist1SearchData : [BookAPIHelper.BookModel] = []
    var booklist2SearchData : [BookAPIHelper.BookModel] = []
    var booklist3SearchData : [BookAPIHelper.BookModel] = []
    
    var savedImageData = Dictionary<String, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        username.text = GlobalData.shared.signedInAccount?.email
        
        setBookValues()
        checkBookValues()
        
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
    
    func setBookValues() {
        booksList1 = BookAPIHelper.shared.getBookBySubject(subject: "Nonfiction")
        booksList2 = BookAPIHelper.shared.getBookBySubject(subject: "Fiction")
        
        booksList3 = []
        
        let DLBookList = DLBookDBHelper.shared.getAllBooks()
        for b in DLBookList {
            var book = BookAPIHelper.BookModel(title: b.title, author_name: [], subject: [], cover_edition_key: nil, cover_i: nil)
            book.download_url = b.filename//Bundle.main.path(forResource: b.filename, ofType: b.fileextension)
            book.thumbnail_url = Bundle.main.path(forResource: b.iconname, ofType: b.iconextension)
            booksList3.append(book)
        }
        
        var tempList1 : [BookAPIHelper.BookModel] = []
        for b in booksList1 {
            if let url = b.thumbnail_url {
                tempList1.append(b)
            }
        }
        booksList1 = tempList1
        
        var tempList2 : [BookAPIHelper.BookModel] = []
        for b in booksList2 {
            if let url = b.thumbnail_url {
                tempList2.append(b)
            }
        }
        booksList2 = tempList2
        
        savedImageData = BookAPIHelper.shared.savedImageData//Dictionary<String, UIImage>()
        
        booklist1SearchData = booksList1
        booklist2SearchData = booksList2
        booklist3SearchData = booksList3
    }
    
    func reloadAllCollectionViews() {
        collectionView1.reloadData()
        collectionView2.reloadData()
        collectionView3.reloadData()
    }
    
    func checkBookValues() {
        if BookAPIHelper.shared.fetchedBookData.isEmpty {
            BookAPIHelper.shared.searchBooks()
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) {_ in
                self.checkBookValues()
            }
        } else if booksList1.isEmpty || booksList2.isEmpty {
            setBookValues()
            reloadAllCollectionViews()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        if (segue.identifier == "bookSegue") {
            let pageView = segue.destination as! BookViewController
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
            return booklist1SearchData.count
        } else if collectionView == self.collectionView2 {
            return booklist2SearchData.count
        } else if collectionView == self.collectionView3 {
            return booklist3SearchData.count
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
            cell1.bookTitleLabel?.text = booklist1SearchData[indexPath.row].title
            cell1.layer.cornerRadius = 30
            cell1.bookBackdropView.layer.cornerRadius = 15
            
            let bookThumbnail = booklist1SearchData[indexPath.row].thumbnail_url
            if bookThumbnail != nil && savedImageData.keys.contains(bookThumbnail!) {
                cell1.bookImage.image = savedImageData[bookThumbnail!]
            } else {
                if let thumbnailURL = booklist1SearchData[indexPath.row].thumbnail_url, let thumbnail = URL(string: thumbnailURL) {
                    let session = URLSession(configuration: .default)

                    let downloadImageTask = session.dataTask(with: thumbnail) { data, response, error in
                        if let error = error {
                            print("Error getting thumbnail")
                            return
                        }
                        
                        if let imageData = data {
                            DispatchQueue.main.async {
                                let newImage = UIImage(data: imageData)
                                cell1.bookImage.image = newImage
                                self.savedImageData[thumbnailURL] = newImage
                            }
                        }
                    }
                    downloadImageTask.resume()
                }
            }
            return cell1
        } else if collectionView == self.collectionView2 {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "bookcell2", for: indexPath) as! BookCollectionViewCell
            cell2.bookTitleLabel?.text = booklist2SearchData[indexPath.row].title
            cell2.layer.cornerRadius = 30
            cell2.bookBackdropView.layer.cornerRadius = 15

            let bookThumbnail = booklist2SearchData[indexPath.row].thumbnail_url
            if bookThumbnail != nil && savedImageData.keys.contains(bookThumbnail!) {
                cell2.bookImage.image = savedImageData[bookThumbnail!]
            } else {
                
                if let thumbnailURL = booklist2SearchData[indexPath.row].thumbnail_url, let thumbnail = URL(string: thumbnailURL) {
                    let session = URLSession(configuration: .default)

                    let downloadImageTask = session.dataTask(with: thumbnail) { data, response, error in
                        if let error = error {
                            print("Error getting thumbnail")
                            return
                        }
                        
                        if let imageData = data {
                            DispatchQueue.main.async {
                                let newImage = UIImage(data: imageData)
                                cell2.bookImage.image = newImage
                                self.savedImageData[thumbnailURL] = newImage
                            }
                        }
                    }
                    downloadImageTask.resume()
                }
            }
            return cell2
        } else {
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "bookcell3", for: indexPath) as! BookCollectionViewCell
            cell3.bookTitleLabel?.text = booklist3SearchData[indexPath.row].title
            cell3.layer.cornerRadius = 30
            cell3.bookBackdropView.layer.cornerRadius = 15
            if let imageName = booklist3SearchData[indexPath.row].thumbnail_url {
                cell3.bookImage.image = UIImage(named: imageName)
            }
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
        switch collectionView {
            case self.collectionView1:
            self.performSegue(withIdentifier: "bookSegue", sender: booklist1SearchData[indexPath.row])
            case self.collectionView2:
            self.performSegue(withIdentifier: "bookSegue", sender: booklist2SearchData[indexPath.row])
            case self.collectionView3:
            self.performSegue(withIdentifier: "bookSegue", sender: booklist3SearchData[indexPath.row])
            default:
                break
        }
        
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

extension BooksViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        booklist1SearchData = getFilteredData(searchText: searchText, bookArray: booksList1)
        booklist2SearchData = getFilteredData(searchText: searchText, bookArray: booksList2)
        booklist3SearchData = getFilteredData(searchText: searchText, bookArray: booksList3)
        
        reloadAllCollectionViews()
        //collectionView1.reloadData()
        //collectionView2.reloadData()
        //collectionView3.reloadData()
    }
    
    
    func getFilteredData(searchText: String, bookArray: [BookAPIHelper.BookModel]) -> [BookAPIHelper.BookModel] {
        var filteredData = searchText.isEmpty ? bookArray : bookArray.filter {
            (book: BookAPIHelper.BookModel) -> Bool in
            return book.title?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        return filteredData
    }

}
