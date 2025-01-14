//
//  SearchViewController.swift
//  TakeItEasy
//
//  Created by Saul on 1/13/25.
//

import UIKit
import WebKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var viewContainer: UIView!
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createBrowser()
    }
    
    
    func createBrowser() {
        webView = WKWebView()
        
        let url = URL(string: "https://www.google.com")
        webView.load(URLRequest(url: url!))
        
        webView.frame = viewContainer.bounds
        viewContainer.addSubview(webView)

    }

}
