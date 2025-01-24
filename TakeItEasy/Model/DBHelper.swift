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
    private var db: OpaquePointer?
    private var accountList = [Account]()
    private var notesList = [Note]()
    
    private init() {}
    
    func createDatabase() {
        
        let fPath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("takeiteasy.sqlite")
        
        if sqlite3_open(fPath.path, &db) != SQLITE_OK {
            print("Cannot open database")
        }
    }
    
    
    /// Accounts
    
    func createAccountTable() {
        
        let sql = "CREATE TABLE IF NOT EXISTS account(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, password TEXT, points INTEGER, time_account_created TEXT, quiz_taken_count INTEGER, quiz_total_score INTEGER)"
        
        if sqlite3_exec(db,sql,nil,nil,nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
    }
    
    
    func alterAccountTable() {
        var sql = "ALTER TABLE account ADD COLUMN quiz_taken_count INTEGER DEFAULT 0"
        if sqlite3_exec(db,sql,nil,nil,nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        sql = "ALTER TABLE account ADD COLUMN quiz_total_score INTEGER DEFAULT 0"
        if sqlite3_exec(db,sql,nil,nil,nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
    }
    
    
    func insertAccount(email: NSString, password: NSString) {
        var stmt : OpaquePointer?
        let query = "INSERT INTO account(email, password, points, time_account_created, quiz_taken_count, quiz_total_score) values (?,?,?,?,?,?)"
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
        
        if sqlite3_bind_int(stmt, 5, 0) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_bind_int(stmt, 6, 0) != SQLITE_OK {
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
    
    
    func updateAccountQuizResults(id: Int32, quizTakenCount: Int, quizTotalScore: Int, points: Int) {
        var stmt : OpaquePointer?
        let query = "UPDATE account SET quiz_taken_count = ?, quiz_total_score = ?, points = ? WHERE id = ?"
        
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_bind_int(stmt, 1, Int32(quizTakenCount)) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_bind_int(stmt, 2, Int32(quizTotalScore)) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }

        if sqlite3_bind_int(stmt, 3, Int32(points)) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_bind_int(stmt, 4, id) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        } else {
            print("Account updated")
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
            let fetchedEmail = String(cString: sqlite3_column_text(stmt, 1))
            let fetchedPassword = String(cString: sqlite3_column_text(stmt, 2))
            let fetchedPoints = Int(sqlite3_column_int(stmt, 3))
            let fetchedDate = ISO8601DateFormatter().date(from: String(cString: sqlite3_column_text(stmt, 4)))
            let fetchedQuizCount = Int(sqlite3_column_int(stmt, 5))
            let fetchedTotalScore = Int(sqlite3_column_int(stmt, 6))
            
            let fetchedAccount = Account(id: id, email: fetchedEmail, password: fetchedPassword, points: fetchedPoints, timeAccountCreated: fetchedDate, quizTakenCount: fetchedQuizCount, quizTotalScore: fetchedTotalScore)
            accountList.append(fetchedAccount)
        }
        
        return accountList
    }
    
    func fetchAccountByEmail(email: NSString) -> Account? {
        var fetchedAccount : Account?
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
            let fetchedEmail = String(cString: sqlite3_column_text(stmt, 1))
            let fetchedPassword = String(cString: sqlite3_column_text(stmt, 2))
            let fetchedPoints = Int(sqlite3_column_int(stmt, 3))
            let fetchedDate = ISO8601DateFormatter().date(from: String(cString: sqlite3_column_text(stmt, 4)))
            let fetchedQuizCount = Int(sqlite3_column_int(stmt, 5))
            let fetchedTotalScore = Int(sqlite3_column_int(stmt, 6))
            
            fetchedAccount = Account(id: id, email: fetchedEmail, password: fetchedPassword, points: fetchedPoints, timeAccountCreated: fetchedDate, quizTakenCount: fetchedQuizCount, quizTotalScore: fetchedTotalScore)
        } else {
            print("Could not get account")
        }
        
        sqlite3_finalize(stmt)
        
        return fetchedAccount
    }
    
    
    func fetchAccountByID(id: Int32) -> Account? {
        var fetchedAccount : Account?
        var stmt : OpaquePointer?
        let query = "SELECT * FROM account WHERE id = ?"
        
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_bind_int(stmt, 1, id) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_step(stmt) == SQLITE_ROW {
            let id = sqlite3_column_int(stmt, 0)
            let fetchedEmail = String(cString: sqlite3_column_text(stmt, 1))
            let fetchedPassword = String(cString: sqlite3_column_text(stmt, 2))
            let fetchedPoints = Int(sqlite3_column_int(stmt, 3))
            let fetchedDate = ISO8601DateFormatter().date(from: String(cString: sqlite3_column_text(stmt, 4)))
            let fetchedQuizCount = Int(sqlite3_column_int(stmt, 5))
            let fetchedTotalScore = Int(sqlite3_column_int(stmt, 6))
            
            fetchedAccount = Account(id: id, email: fetchedEmail, password: fetchedPassword, points: fetchedPoints, timeAccountCreated: fetchedDate, quizTakenCount: fetchedQuizCount, quizTotalScore: fetchedTotalScore)
        } else {
            print("Could not get account")
        }
        
        sqlite3_finalize(stmt)
        
        return fetchedAccount
    }
    
    /// Notes

    
    func createNoteTable() {
        let sql = "CREATE TABLE IF NOT EXISTS note(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, time_last_edit TEXT, pinned INTEGER, account_id INTEGER)"
        
        if sqlite3_exec(db,sql,nil,nil,nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
    }
    
    
    func insertNote(accountID: Int32) -> Note? {
        var newNote : Note?
        var stmt : OpaquePointer?
        let query = "INSERT INTO note(title, content, time_last_edit, pinned, account_id) values (?,?,?,?,?) RETURNING *"
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        let newNoteString = "New Note"
        
        if sqlite3_bind_text(stmt, 1, NSString(string: newNoteString).utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_bind_text(stmt, 2, NSString(string: newNoteString).utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        let new_date = Date()
        if sqlite3_bind_text(stmt, 3, NSString(string: new_date.ISO8601Format()).utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }

        if sqlite3_bind_int(stmt, 4, 0) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_bind_int(stmt, 5, accountID) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_step(stmt) != SQLITE_ROW {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        } else {
            let id = sqlite3_column_int(stmt, 0)
            let fetchedTitle = String(cString: sqlite3_column_text(stmt, 1))
            let fetchedContent = String(cString: sqlite3_column_text(stmt, 2))
            let fetchedTimeLastEdit = ISO8601DateFormatter().date(from: String(cString: sqlite3_column_text(stmt, 3)))
            let fetchedPinned = sqlite3_column_int(stmt, 4) == 1
            let fetchedAccountID = Int32(sqlite3_column_int(stmt, 5))
            
            newNote = Note(id: id, title: fetchedTitle, content: fetchedContent, timeLastEdit: fetchedTimeLastEdit, pinned: fetchedPinned, accountID: fetchedAccountID)        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        } else {
            print("Note created")
        }
        
        return newNote
    }
    
    
    func deleteNote(id: Int32) {
        var stmt : OpaquePointer?
        let query = "DELETE FROM note WHERE id = ?"
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_bind_int(stmt, 1, id) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            print("Note deleted")
        } else {
            print("Note could not be deleted")
        }
    }
    
    
    func fetchAllNotesByAccount(account_id: Int32) -> [Note] {
        notesList.removeAll()
        var stmt : OpaquePointer?
        let query = "SELECT * FROM note INNER JOIN account ON note.account_id = account.id WHERE note.account_id = ?"
        
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_bind_int(stmt, 1, Int32(account_id)) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            let id = sqlite3_column_int(stmt, 0)
            let fetchedTitle = String(cString: sqlite3_column_text(stmt, 1))
            let fetchedContent = String(cString: sqlite3_column_text(stmt, 2))
            let fetchedTimeLastEdit = ISO8601DateFormatter().date(from: String(cString: sqlite3_column_text(stmt, 3)))
            let fetchedPinned = sqlite3_column_int(stmt, 4) == 1
            let fetchedAccountID = Int32(sqlite3_column_int(stmt, 5))
            
            let fetchedNote = Note(id: id, title: fetchedTitle, content: fetchedContent, timeLastEdit: fetchedTimeLastEdit, pinned: fetchedPinned, accountID: fetchedAccountID)
            notesList.append(fetchedNote)
            
        }
        
        return notesList
    }
    
    
    func updateNoteTitle(id: Int32, title: NSString) {
        var stmt : OpaquePointer?
        let query = "UPDATE note SET title = ?, time_last_edit = ? WHERE id = ?"
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_bind_text(stmt, 1, title.utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        let new_date = Date()
        if sqlite3_bind_text(stmt, 2, NSString(string: new_date.ISO8601Format()).utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_bind_int(stmt, 3, id) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            print("Note title updated")
        } else {
            print("Failed to update title")
        }
        
        sqlite3_finalize(stmt)
    }
    
    
    func updateNoteContent(id: Int32, content: NSString) {
        var stmt : OpaquePointer?
        let query = "UPDATE note SET content = ?, time_last_edit = ? WHERE id = ?"
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_bind_text(stmt, 1, content.utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        let new_date = Date()
        if sqlite3_bind_text(stmt, 2, NSString(string: new_date.ISO8601Format()).utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_bind_int(stmt, 3, id) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            print("Note content updated")
        } else {
            print("Failed to update content")
        }
        
        sqlite3_finalize(stmt)
    }
    
    
    func updateNotePinned(id: Int32, pinned: Bool) {
        var stmt : OpaquePointer?
        let query = "UPDATE note SET pinned = ? WHERE id = ?"
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        sqlite3_bind_int(stmt, 1, pinned ? 1 : 0)
        sqlite3_bind_int(stmt, 2, id)
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            print("Note pin status changed")
        } else {
            print("Failed to update pin status")
        }
        
        sqlite3_finalize(stmt)
    }
    
}
