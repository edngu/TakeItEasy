//
//  GlobalData.swift
//  TakeItEasy
//
//  Created by admin on 1/23/25.
//

import Foundation

class GlobalData {
    
    static var shared = GlobalData()
    private init() {}
    
    var signedInAccount: Account?
    
    
}
