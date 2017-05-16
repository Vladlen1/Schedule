//
//  ScheduleViewModel.swift
//  Schedule
//
//  Created by Влад Бирюков on 12.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation

class ScheduleViewModel {
    
    let date: String
    let lessons: [LessonViewModel]
    
    init(date: String, lessons: [LessonViewModel]) {
        self.date = date
        self.lessons = lessons
    }
}


class LessonViewModel {
    let nameSubject: String
    let typePair: UIImage
    let numberOfPeople: String?
    let nameTeacher: String?
    let timeStart: String
    let timeFinish: String
    let location: String?
    let lessonId: Int
    let visitors: [Visitor]
    
    init(nameSubject: String, typePair: UIImage, numberOfPeople: String?, nameTeacher: String?, timeStart: String, timeFinish: String, location: String?, lessonId: Int, visitors: [Visitor]) {
        self.nameSubject = nameSubject
        self.typePair = typePair
        self.numberOfPeople = numberOfPeople
        self.nameTeacher = nameTeacher
        self.timeStart = timeStart
        self.timeFinish = timeFinish
        self.location = location
        self.lessonId = lessonId
        self.visitors = visitors
    }

}
