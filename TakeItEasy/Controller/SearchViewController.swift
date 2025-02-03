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
    @IBOutlet weak var username: UILabel!
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = GlobalData.shared.signedInAccount?.email
        createBrowser()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tabBarItem.image = UIImage(systemName: "magnifyingglass")
    }
    
    
    func createBrowser() {
        webView = WKWebView()
        
        let url = URL(string: "https://www.google.com")
        webView.load(URLRequest(url: url!))
        
        webView.frame = viewContainer.bounds
        //webView.scrollView.contentInsetAdjustmentBehavior = .automatic
        viewContainer.addSubview(webView)
        
    }
    @IBAction func logOut(_ sender: Any) {
        if let vcA = self.storyboard?.instantiateViewController(withIdentifier: "logincontroller") as? LoginViewController {
            
            self.view.window?.rootViewController = vcA
            self.view.window?.makeKeyAndVisible()
        }
    }
    
}
