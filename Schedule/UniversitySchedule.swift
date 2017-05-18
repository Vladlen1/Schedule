//
//  UniversitySchedule.swift
//  Schedule
//
//  Created by Влад Бирюков on 16.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation

class FacultyGroup {
    let nameFaculty: String
    let groupArr: [Group]
    
    init(nameFaculty: String, groupArr: [Group]) {
        self.nameFaculty = nameFaculty
        self.groupArr = groupArr
    }
}

class Group{
    let groupNumber: String?
    let groupId: Int?
    
    init(number: String?, id: Int?) {
        self.groupNumber = number
        self.groupId = id
    }
}
