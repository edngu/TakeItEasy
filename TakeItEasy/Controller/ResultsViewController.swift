//
//  ResultsViewController.swift
//  TakeItEasy
//
//  Created by Saul on 1/13/25.
//

import UIKit

class ResultsViewController: UIViewController {

    
    @IBOutlet weak var backdropView0: UIView!
    @IBOutlet weak var backdropView1: UIView!
    @IBOutlet weak var backdropView2: UIView!
    @IBOutlet weak var backdropView3: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setupUI(){
        backdropView0.layer.cornerRadius = 20
        backdropView1.layer.cornerRadius = 20
        backdropView2.layer.cornerRadius = 20
        backdropView3.layer.cornerRadius = 20
    }

}
