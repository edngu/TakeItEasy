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
        navigationItem.title = GlobalData.shared.signedInAccount?.email

        DispatchQueue.main.async {
            print("Loading Book")
            if let resourceURL = self.book?.download_url {
                if let document = PDFDocument(url: URL(string: resourceURL)!) {
                    self.pdfView.document = document
                } else if let url = Bundle.main.url(forResource: resourceURL, withExtension: "pdf") {
                    if let document = PDFDocument(url: url) {
                        self.pdfView.document = document
                    }
                }
                
                self.pdfView.autoScales = true
                self.pdfView.frame = self.subView.frame
                self.subView.addSubview(self.pdfView)
                print("Finished Loading Book")
            }
        }
        
    }

}
