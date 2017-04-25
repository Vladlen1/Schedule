//
//  Lesson.swift
//  Schedule
//
//  Created by Влад Бирюков on 25.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation

class Lesson{
    
    let name: String?
    let type: Int
    let note: String?
    let beginAt: String
    let endAt: String
    let teacher: String?
    let location: String?
    
    
    init(name: String?, type: Int, note: String?, beginAt: String, endAt: String, teacher: String?, location: String?) {
        self.name = name
        self.type = type
        self.note = note
        self.beginAt = beginAt
        self.endAt = endAt
        self.teacher = teacher
        self.location = location
    }
}
