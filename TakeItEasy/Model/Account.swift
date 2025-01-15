//
//  Account.swift
//  TakeItEasy
//
//  Created by admin on 1/15/25.
//

import Foundation

class Account {
    
    var id : Int32?
    var email : String?
    var password : String?
    var points : Int?
    var timeAccountCreated : Date?
    
    init(id: Int32? = nil, email: String? = nil, password: String? = nil, points: Int? = nil, timeAccountCreated: Date? = nil) {
        self.id = id
        self.email = email
        self.password = password
        self.points = points
        self.timeAccountCreated = timeAccountCreated
    }
    
}
