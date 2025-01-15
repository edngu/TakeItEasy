//
//  DBHelper.swift
//  TakeItEasy
//
//  Created by admin on 1/15/25.
//

import Foundation
import SQLite3

class DBHelper {
    
    static var dbhelper = DBHelper()
    var db: OpaquePointer?
    var accountList = [Account]()
    
    private init() {}
    
    func createDatabase() {
        
        let fPath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("takeiteasy.sqlite")
        
        if sqlite3_open(fPath.path, &db) != SQLITE_OK {
            print("Cannot open database")
        }
    }
    
    
    func createAccountTable() {
        
        let sql = "CREATE TABLE IF NOT EXISTS account(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, password TEXT, points INTEGER, time_account_created TEXT)"
        
        if sqlite3_exec(db,sql,nil,nil,nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
    }
    
    
    func insertAccount(email: NSString, password: NSString) {
        var stmt : OpaquePointer?
        let query = "INSERT INTO account(email, password, points, time_account_created) values (?,?,?,?)"
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_bind_text(stmt, 1, email.utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_bind_text(stmt, 2, password.utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_bind_int(stmt, 3, 0) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        let new_date = Date()
        if sqlite3_bind_text(stmt, 4, NSString(string: new_date.ISO8601Format()).utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        } else {
            print("Account saved")
        }
    }
    
    
    func fetchAllAccounts() -> [Account] {
        
        accountList.removeAll()
        var stmt : OpaquePointer?
        let query = "SELECT * FROM account"
        if sqlite3_prepare(db, query, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
            return accountList
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            let id = sqlite3_column_int(stmt, 0)
            let fetched_email = String(cString: sqlite3_column_text(stmt, 1))
            let fetched_password = String(cString: sqlite3_column_text(stmt, 2))
            let fetched_points = Int(sqlite3_column_int(stmt, 3))
            let fetched_date = ISO8601DateFormatter().date(from: String(cString: sqlite3_column_text(stmt, 4)))
            
            let fetched_account = Account(id: id, email: fetched_email, password: fetched_password, points: fetched_points, time_account_created: fetched_date)
            accountList.append(fetched_account)
        }
        
        return accountList
    }
    
    func fetchAccountByEmail(email: NSString) -> Account? {
        var fetched_account : Account?
        var stmt : OpaquePointer?
        let query = "SELECT * FROM account WHERE email = ?"
        
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_bind_text(stmt, 1, email.utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_step(stmt) == SQLITE_ROW {
            let id = sqlite3_column_int(stmt, 0)
            let fetched_email = String(cString: sqlite3_column_text(stmt, 1))
            let fetched_password = String(cString: sqlite3_column_text(stmt, 2))
            let fetched_points = Int(sqlite3_column_int(stmt, 3))
            let fetched_date = ISO8601DateFormatter().date(from: String(cString: sqlite3_column_text(stmt, 4)))
            
            fetched_account = Account(id: id, email: fetched_email, password: fetched_password, points: fetched_points, time_account_created: fetched_date)
        } else {
            print("Could not get account")
        }
        
        sqlite3_finalize(stmt)
        
        return fetched_account
    }
    
    
}
