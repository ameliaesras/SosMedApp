//
//  User.swift
//  SosMedApp
//
//  Created by Amelia Esra S on 07/01/22.
//

import Foundation

class User {
    
    var id:Int
    var name: String
    var username: String
    var email: String
    var address: String
    var phone: String
    
    init(id:Int, name: String, username: String, email: String, address: String, phone: String) {
        
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.phone = phone
    }
}
