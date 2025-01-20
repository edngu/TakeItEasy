//
//  BookPageViewController.swift
//  TakeItEasy
//
//  Created by Saul on 1/16/25.
//

import UIKit
import PDFKit

class BookPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    //lazy var vcArr: [UIViewController] = { return [self.viewControllerInstance("VC1"), viewControllerInstance("VC2")] }()
    var vcArr = [UIViewController]()
    var pageText: String?
    var pdfView = PDFView()
    var book: BookAPIHelper.BookModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        if let resourseURL = book?.download_url {
            let document = PDFDocument(url: URL(string: resourseURL)!)
            pdfView.document = document
            
            let bvc = BookViewController()
            bvc.view = pdfView
            vcArr.append(bvc)
        }
        
        
        //Adding new placeholder pages in PageViewController
        for i in 0...4{
            let bvc = BookViewController()
            
            switch i {
            case 0: bvc.view.backgroundColor = .purple
            case 1: bvc.view.backgroundColor = .green
            case 2: bvc.view.backgroundColor = .blue
            case 3: bvc.view.backgroundColor = .yellow
            default : bvc.view.backgroundColor = .red
            }
            
            vcArr.append(bvc)
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presentViewController()
    }
    
    func presentViewController(){
        guard let firstVC = vcArr.first else { return }
        
        let pageVC = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        pageVC.delegate = self
        pageVC.dataSource = self
        pageVC.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        
        present(pageVC, animated: true, completion: nil)
    }
    
    
    //Convert String to actual ViewController instance
//    func viewControllerInstance(_ name: String) -> UIViewController {
//        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
//    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = vcArr.firstIndex(of: viewController) else { return nil }
        
        let previousVCIndex = vcIndex - 1
        
        guard previousVCIndex >= 0 else { return vcArr.last}
        
        guard vcArr.count > previousVCIndex else { return nil }
        
        return vcArr[previousVCIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = vcArr.firstIndex(of: viewController) else { return nil }
        
        let nextVCIndex = vcIndex + 1
        
        guard nextVCIndex < vcArr.count else { return vcArr.first}
    
        guard vcArr.count > nextVCIndex else { return nil }
        
        return vcArr[nextVCIndex]
    }

//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return vcArr.count
//    }
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        guard let vcIndex = vcArr.firstIndex(of: pageViewController.viewControllers!.first!) else { return 0 }
//        
//        return vcIndex
//    }
    
    
    
}
