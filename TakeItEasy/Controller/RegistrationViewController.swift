//
//  RegistrationViewController.swift
//  TakeItEasy
//
//  Created by Saul on 1/13/25.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    var emailText : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        email.text = emailText
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
    
    @IBAction func register(_ sender: Any) {
        
        
        
        print("User created, data saved successfully")
        self.navigationController?.popViewController(animated: true)
        self.performSegue(withIdentifier: "tabSegue", sender: nil)
    }
    

}
