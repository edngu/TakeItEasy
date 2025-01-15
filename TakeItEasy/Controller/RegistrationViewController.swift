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
    
    
    enum AccountValidationResponse : String {
        case valid = ""
        case usernameEmpty = "Email cannot be empty"
        case usernameContainsSpace = "Email cannot contain spaces"
        case invalidUsernameFormat = "Email must be in the format abc@xyz.com"
        case usernameInUse = "An account already exists with this email"
        case passwordNotMatching = "Passwords do not match"
        case passwordNotLong = "Password must be atleast 6 characters"
        case passwordNoSpecialCharacter = "Password must contain a special character"
        case passwordNoNumber = "Password must contain a number"
        case passwordNoCapital = "Password must contain a capital"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.text = emailText
        // Do any additional setup after loading the view.
    }
    

    func validateAccount(user: String, pwd: String, pwd2: String) -> AccountValidationResponse {
        
        /// Verify the email
        
        guard user != "" else {
            return AccountValidationResponse.usernameEmpty
        }
        
        guard !user.contains(" ") else {
            return AccountValidationResponse.usernameContainsSpace
        }
        
        let emailRegEx = "[A-Z0-9a-z._-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,3}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        
        guard emailPredicate.evaluate(with: user) else {
            return AccountValidationResponse.invalidUsernameFormat
        }
        
        let acc = DBHelper.dbhelper.fetchAccountByEmail(email: user as NSString)
        guard acc == nil else {
            return AccountValidationResponse.usernameInUse
        }
        
        /// Verify the password
        
        guard pwd.count >= 6 else {
            return AccountValidationResponse.passwordNotLong
        }
        
        let specialCharacters = CharacterSet(charactersIn: "!@#$%^&*()_+-=<>?,./:\";'[]{}|\\")
        guard let _ = pwd.rangeOfCharacter(from: specialCharacters) else {
            return AccountValidationResponse.passwordNoSpecialCharacter
        }
        
        let numericCharacters = CharacterSet(charactersIn: "1234567890")
        guard let _ = pwd.rangeOfCharacter(from: numericCharacters) else {
            return AccountValidationResponse.passwordNoNumber
        }
        
        let capitalCharacters = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        guard let _ = pwd.rangeOfCharacter(from: capitalCharacters) else {
            return AccountValidationResponse.passwordNoCapital
        }
        
        guard pwd == pwd2 else {
            return AccountValidationResponse.passwordNotMatching
        }
        
        
        return AccountValidationResponse.valid
    }
    
    
    
    @IBAction func register(_ sender: Any) {
        
        let validationResponse = validateAccount(user: email.text!.lowercased(), pwd: password.text!, pwd2: confirmPassword.text!)
        
        errorLabel.isHidden = false
        errorLabel.text = validationResponse.rawValue
        
        guard validationResponse == AccountValidationResponse.valid else {
            return
        }
        
        DBHelper.dbhelper.insertAccount(email: email.text!.lowercased() as NSString, password: password.text! as NSString)
        
        print("User created, data saved successfully")
        /*let p = DBHelper.dbhelper.fetchAllAccounts()
        for a in p {
            print("\(a.email), \(a.password), \(a.points), \(a.time_account_created)")
        }*/
        self.navigationController?.popViewController(animated: true)
        self.performSegue(withIdentifier: "tabSegue", sender: nil)
         
    }
    

}
