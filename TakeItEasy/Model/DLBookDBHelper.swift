//
//  DLBookDBHelper.swift
//  TakeItEasy
//
//  Created by admin on 1/29/25.
//

import Foundation
import CoreData

class DLBookDBHelper {
    
    let context = DLBookPersistentStorage.shared.context
    static var shared = DLBookDBHelper()
    
    private init() {}
    
    func addBook(title: String?, fileName: String?, fileExtension: String?, iconName: String?, iconExtension: String?) {
        let book = NSEntityDescription.insertNewObject(forEntityName: "DLBook", into: context) as? DLBook
        book?.title = title
        book?.filename = fileName
        book?.fileextension = fileExtension
        book?.iconname = iconName
        book?.iconextension = iconExtension
        do {
            try context.save()
        } catch let error {
            print("Error \(error)")
        }
    }
    
    func getAllBooks() -> [DLBook] {
        var books: [DLBook] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DLBook")
        
        do {
            books = try context.fetch(fetchRequest) as! [DLBook]
        } catch let error {
            print("Error \(error)")
        }
        return books
    }
    
    
    func addInitialBooks() {
        addBook(title: "Green Eggs and Ham", fileName: "greeneggsham", fileExtension: "pdf", iconName: "greeneggsandham", iconExtension: "jpg")
        addBook(title: "Cinderella", fileName: "cinderella", fileExtension: "pdf", iconName: "princess", iconExtension: "png")
    }
    
}
