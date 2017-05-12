//
//  Schedule.swift
//  Schedule
//
//  Created by Влад Бирюков on 12.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation

public class Schedule{
    
    let date: String?
    let lessons: [Lesson?]?
    
    init(date: String, lessons: [Lesson]) {
        self.date = date
        self.lessons = lessons
    }
}
