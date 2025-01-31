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
    let userDefault = UserDefaults.standard
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetTextFieldBorders()
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
    
    
    func resetTextFieldBorders() {
        email.layer.borderColor = .none
        email.layer.borderWidth = 0
        password.layer.borderColor = .none
        password.layer.borderWidth = 0
        confirmPassword.layer.borderColor = .none
        confirmPassword.layer.borderWidth = 0
    }
    
    
    func setErrorTextFieldBorder(textField: UITextField) {
        textField.layer.borderColor = .init(red: 1, green: 0, blue: 0, alpha: 1)
        textField.layer.borderWidth = 1.0
    }
    
    
    func saveKey(username: String, password: String) {
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username.lowercased(),
            kSecValueData as String : password.data(using: .utf8)!]
        
        if SecItemAdd(attributes as CFDictionary, nil) == errSecSuccess {
            print("data saved successfully")
        } else {
            print("data not saved")
        }
    }
    
    
    func getKey(username: String) -> (String?, String?) {
        let request : [String : Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : username.lowercased(),
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
    
    
    func saveAccount(username: String, password: String) {
        let usernameLowercased = username.lowercased()
        DBHelper.dbhelper.insertAccount(email: usernameLowercased as NSString, password: password as NSString)
        saveKey(username: usernameLowercased, password: password)
    }
    
    func removeRememberAccount() {
        userDefault.set("", forKey: "username")
        userDefault.set(false, forKey: "remember")
    }
    
    @IBAction func register(_ sender: Any) {
        
        resetTextFieldBorders()
        let validationResponse = validateAccount(user: email.text!.lowercased(), pwd: password.text!, pwd2: confirmPassword.text!)
        
        errorLabel.isHidden = false
        errorLabel.text = validationResponse.rawValue
        
        guard validationResponse == AccountValidationResponse.valid else {
            switch validationResponse {
            case AccountValidationResponse.invalidUsernameFormat:
                fallthrough
            case AccountValidationResponse.usernameContainsSpace:
                fallthrough
            case AccountValidationResponse.usernameEmpty:
                fallthrough
            case AccountValidationResponse.usernameInUse:
                setErrorTextFieldBorder(textField: email)
            
            case AccountValidationResponse.passwordNoCapital:
                fallthrough
            case AccountValidationResponse.passwordNoNumber:
                fallthrough
            case AccountValidationResponse.passwordNoSpecialCharacter:
                fallthrough
            case AccountValidationResponse.passwordNotLong:
                setErrorTextFieldBorder(textField: password)
                
            case AccountValidationResponse.passwordNotMatching:
                setErrorTextFieldBorder(textField: confirmPassword)
            
            default:
                break
            }
            return
        }
        
        saveAccount(username: email.text!, password: password.text!)
        //DBHelper.dbhelper.insertAccount(email: email.text!.lowercased() as NSString, password: password.text! as NSString)
        
        removeRememberAccount()
        print("User created, data saved successfully")
        GlobalData.shared.signedInAccount = DBHelper.dbhelper.fetchAccountByEmail(email: email.text! as NSString)
        
        self.navigationController?.popViewController(animated: true)
        self.performSegue(withIdentifier: "tabSegue", sender: nil)
         
    }
    

}
