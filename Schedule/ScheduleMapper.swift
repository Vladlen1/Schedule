//
//  ScheduleMapper.swift
//  Schedule
//
//  Created by Влад Бирюков on 12.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation


class ScheduleMapper {
    
    func tranformScheduleObject(schedules: [Schedule]) -> [ScheduleViewModel] {
        
        var resultArrSchedule = [ScheduleViewModel]()
        
        for schedule in schedules{
            var lessonsArr = [LessonViewModel]()
            var typePair: UIImage
            var numberOfPeople: String
        
            for lesson in schedule.lessons! {
                let nameSubject = lesson?.name
                if lesson?.type == 1 {
                    typePair = UIImage(named: "green")!
                } else if lesson?.type == 2 {
                    typePair = UIImage(named: "red")!
                } else {
                    typePair = UIImage(named: "yellow")!
                }
                if lesson != nil{
                    numberOfPeople = String(describing: lesson!.visitors.count)

                }else{
                    numberOfPeople = "0"
                }
                let nameTeacher = lesson?.teacher
                let timeStart = lesson?.beginAt
                let timeFinish = lesson?.endAt
                let location = lesson?.location
                let lessonId = lesson?.lessonsId
                
                var visitistArr = [Visitor]()
                for visit in (lesson?.visitors)!{
                    visitistArr.append(Visitor(email:visit.email, firstName: visit.firstName, lastName: visit.lastName, userId: visit.userId))
                }
            
                lessonsArr.append(LessonViewModel(nameSubject: nameSubject!, typePair: typePair, numberOfPeople: numberOfPeople, nameTeacher: nameTeacher, timeStart: timeStart!, timeFinish: timeFinish!, location: location, lessonId: lessonId!, visitors: visitistArr))
            }
            resultArrSchedule.append (ScheduleViewModel(date: schedule.date! , lessons: lessonsArr))
        }
        return resultArrSchedule
    }
}
