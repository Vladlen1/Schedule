//
//  Visitor.swift
//  Schedule
//
//  Created by Влад Бирюков on 26.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation


public class Visitor{
    
    let email: String
    let firstName: String
    let lastName: String
    let userId: Int
    
    init(email: String, firstName: String, lastName: String, userId: Int) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.userId = userId
 
    }
    
    
}
