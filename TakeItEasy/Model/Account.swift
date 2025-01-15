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
    var time_account_created : Date?
    
    init(id: Int32? = nil, email: String? = nil, password: String? = nil, points: Int? = nil, time_account_created: Date? = nil) {
        self.id = id
        self.email = email
        self.password = password
        self.points = points
        self.time_account_created = time_account_created
    }
    
}
