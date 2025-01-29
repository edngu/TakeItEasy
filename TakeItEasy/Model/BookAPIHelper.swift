//
//  BookAPIHelper.swift
//  TakeItEasy
//
//  Created by admin on 1/17/25.
//

import Foundation
import PDFKit

class BookAPIHelper {
    
    static var shared = BookAPIHelper()
    
    private init() {}
    
    struct BookModel: Decodable {
        let title: String?
        let author_name: [String?]
        let subject: [String?]
        let cover_edition_key: String?
        let cover_i: Int?
        var thumbnail_url: String?
        var preview_url: String?
        var download_url: String?
    }
    
    struct BookData: Decodable {
        let docs: [BookModel]
    }
    
    var fetchedBookData : [BookModel] = []
    
    func searchBooks() {
        
        let parameters: [String: String] = [
            "subject": "fiction,nonfiction",
            "ebook_access": "public",
            "limit": "25",
            "fields": "cover_edition_key,cover_i,title,author_name,subject"
        ]
        
        var urlComponents = URLComponents(string: "https://openlibrary.org/search.json")!
        urlComponents.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        guard let request = urlComponents.url else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error getting books")
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let books = try JSONDecoder().decode(BookData.self, from: data)

                self.fetchedBookData = books.docs
                self.getBookData()
                
            } catch let error {
                print("Failed to get books: \(error)")
            }
            
        }
        task.resume()
    }
    
    
    func getBookData() {
        
        var ids = ""
        for b in fetchedBookData {
            if let id = b.cover_edition_key {
                ids += "\(id),"
            }
            
        }

        let parameters: [String: String] = [
            "bibkeys": ids,
            "preview": "full",
            "format": "json",
        ]
        
        var urlComponents = URLComponents(string: "https://openlibrary.org/api/books")!
        urlComponents.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        guard let request = urlComponents.url else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error getting books")
            }
            
            guard let data = data else {
                return
            }
            
            do {
                
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Dictionary<String, String>] {
                    
                    var nilIndexes: [Int] = []
                    for i in 0..<self.fetchedBookData.count {
                        guard let _ = self.fetchedBookData[i].cover_edition_key else {
                            nilIndexes.append(i)
                            continue
                        }
                        guard json[self.fetchedBookData[i].cover_edition_key!]!["preview"] == "full" else {
                            nilIndexes.append(i)
                            continue
                        }
                        
                        //self.fetchedBookData[i].thumbnail_url = json[self.fetchedBookData[i].cover_edition_key!]!["thumbnail_url"]
                        let coverID = self.fetchedBookData[i].cover_i!//String(json[self.fetchedBookData[i].cover_edition_key!]!["cover_i"])
                        self.fetchedBookData[i].thumbnail_url = "https://covers.openlibrary.org/b/id/\(coverID)-L.jpg"
                        self.fetchedBookData[i].preview_url = json[self.fetchedBookData[i].cover_edition_key!]!["preview_url"]
                        
                        let bookID = json[self.fetchedBookData[i].cover_edition_key!]!["preview_url"]?.split(separator: "/").last
                        self.fetchedBookData[i].download_url = "https://archive.org/download/\(bookID!)/\(bookID!).pdf"
                    }
                    for i in nilIndexes.reversed() {
                        self.fetchedBookData.remove(at: i)
                    }
                    //self.openBookPDF(download_url: self.fetchedBookData[0].download_url!)
                    
                }
                
            } catch let error {
                print("Failed to get books: \(error)")
            }
            
        }
        task.resume()
    }
    
    
}
