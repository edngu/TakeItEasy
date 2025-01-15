//
//  Note.swift
//  TakeItEasy
//
//  Created by admin on 1/15/25.
//

import Foundation

class Note {
    
    var id : Int32?
    var title : String?
    var content : String?
    var timeLastEdit : Date?
    var pinned : Bool?
    var accountID : Int32?
    
    init(id: Int32? = nil, title: String? = "Note", content: String? = "", timeLastEdit: Date? = Date(), pinned: Bool? = false, accountID: Int32? = nil) {
        self.id = id
        self.title = title
        self.content = content
        self.timeLastEdit = timeLastEdit
        self.pinned = pinned
        self.accountID = accountID
    }
    
}
