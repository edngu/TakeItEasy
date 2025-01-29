//
//  LoginViewController.swift
//  TakeItEasy
//
//  Created by Saul on 1/13/25.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var rememberMe: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        DBHelper.dbhelper.createDatabase()
        DBHelper.dbhelper.createAccountTable()
        DBHelper.dbhelper.createNoteTable()
        DBHelper.dbhelper.alterAccountTable()
        BookAPIHelper.shared.searchBooks()
        //QuizDBHelper.shared.addMathQuiz()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //Send over username text to registration page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "registerSegue" {
            let destinationVC = segue.destination as! RegistrationViewController
            destinationVC.emailText = email.text
        }
    }
    
    
    @IBAction func login(_ sender: Any) {
        
        /// replace later with actual login
        if let a = DBHelper.dbhelper.fetchAccountByID(id: 1) {
            a.password = ""
            GlobalData.shared.signedInAccount = a
        } else {
            GlobalData.shared.signedInAccount = Account(id: 1, email: "", password: "", points: 0, timeAccountCreated: nil, quizTakenCount: 0, quizTotalScore: 0)
        }
        self.performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    

    
}
