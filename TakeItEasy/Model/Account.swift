//
//  Account.swift
//  TakeItEasy
//
//  Created by admin on 1/15/25.
//

import Foundation

class Account {
    
    var email : String?
    var password : String?
    var points : Int?
    var time_account_created : Date?
    
    init(email: String? = nil, password: String? = nil, points: Int? = nil, time_account_created: Date? = nil) {
        self.email = email
        self.password = password
        self.points = points
        self.time_account_created = time_account_created
    }
    
}
