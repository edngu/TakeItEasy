//
//  BookViewController.swift
//  TakeItEasy
//
//  Created by Saul on 1/13/25.
//

import UIKit
import PDFKit

class BookViewController: UIViewController {

    var book : BookAPIHelper.BookModel?
    var pdfView = PDFView()
    
    @IBOutlet weak var subView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            print("Loading Book")
            if let resourseURL = self.book?.download_url {
                if let document = PDFDocument(url: URL(string: resourseURL)!) {
                    self.pdfView.document = document
                } else if let document = PDFDocument(url: Bundle.main.url(forResource: resourseURL, withExtension: "pdf")!) {
                    self.pdfView.document = document
                }
                
                self.pdfView.autoScales = true
                self.pdfView.frame = self.subView.frame
                self.subView.addSubview(self.pdfView)
                print("Finished Loading Book")
            }
        }
        
    }

}
