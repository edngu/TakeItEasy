//
//  LoginViewController.swift
//  TakeItEasy
//
//  Created by Saul on 1/13/25.
//

import UIKit

class LoginViewController: UIViewController {

    let userDefault = UserDefaults.standard
    
    @IBOutlet weak var alertLabel: UILabel!
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
        //QuizDBHelper.shared.deleteAllQuizzes()
        //QuizDBHelper.shared.addMathQuiz()
        //QuizDBHelper.shared.addSwiftQuiz()
        //QuizDBHelper.shared.addVocabQuiz()
        //DLBookDBHelper.shared.addInitialBooks()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        alertLabel.isHidden = true
        
        let rememberedAccount = getRememberAccount()
        
        if rememberedAccount.1 {
            let data = getKey(username: rememberedAccount.0)
            if let username = data.0 {
                email.text = username
            }
            if let pwd = data.1 {
                password.text = pwd
            }
        } else {
            email.text = ""
            password.text = ""
        }
    }
    
    
    //Send over username text to registration page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "registerSegue" {
            let destinationVC = segue.destination as! RegistrationViewController
            destinationVC.emailText = email.text
        }
    }
    
    
    func saveRememberAccount(username: String) {
        if rememberMe.isOn {
            userDefault.set(username.lowercased(), forKey: "username")
        } else {
            userDefault.set("", forKey: "username")
        }
        
        userDefault.set(rememberMe.isOn, forKey: "remember")
    }
    
    
    func getRememberAccount() -> (String, Bool){
        let userID = userDefault.string(forKey: "username")
        let state = userDefault.bool(forKey: "remember")
        
        if userID != nil {
            return (userID!, state)
        }
        return ("", false)
        
    }

    
    func getKey(username: String) -> (String?, String?) {
        let request : [String : Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : username,
            kSecReturnAttributes as String : true,
            kSecReturnData as String : true
        ]
        var response : CFTypeRef?
        
        if SecItemCopyMatching(request as CFDictionary, &response) == noErr {
            let data = response as? [String : Any]
            let userID = data?[kSecAttrAccount as String] as? String
            let password = (data![kSecValueData as String] as? Data)!
            let passStr = String(data: password, encoding: .utf8)
            return (userID!, passStr!)
        }
        return ("", "")
    }
    
    
    func validate(username: String, password: String) -> Bool {
        let usernameLowercased = username.lowercased()
        if let account = DBHelper.dbhelper.fetchAccountByEmail(email: usernameLowercased as NSString) {
            return account.password == password
        }
        return false
    }
    
    
    @IBAction func login(_ sender: Any) {
        
        guard validate(username: email.text!, password: password.text!) else {
            alertLabel.isHidden = false
            print("Invalid Email-Password Combination")
            return
        }
        
        saveRememberAccount(username: email.text!)
        GlobalData.shared.signedInAccount = DBHelper.dbhelper.fetchAccountByEmail(email: email.text!.lowercased() as NSString)
        self.performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    

    
}
