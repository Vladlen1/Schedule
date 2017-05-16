//
//  TransformJson.swift
//  Schedule
//
//  Created by Влад Бирюков on 12.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import SwiftyVK

class TransformJson{
    
    func transformJsonScheduleObject(json: Any, subgroup: String) -> [Schedule]{
        let json = JSON(json)
        var result = [Schedule]()
        for (_, subJson):(String, JSON) in json["results"] {
            let date = subJson["date"].string!
            
            var lessonsList = [Lesson]()
            for (_, lessons):(String, JSON) in subJson["lessons"] {
                var visitorList = [Visitor]()
                for (_, visitors):(String, JSON) in lessons["visitors"]{
                    
                    visitorList.append(Visitor(email: visitors["email"].string!, firstName: visitors["first_name"].string!, lastName: visitors["last_name"].string!, userId: visitors["id"].int!))
                }
                
                if subgroup == lessons["note"].string || lessons["note"].string == ""{
                    lessonsList.append(Lesson(name: lessons["name"].string!, type: lessons["type"].int!, note: lessons["note"].string, beginAt: lessons["time"]["beginning_at"].string!, endAt: lessons["time"]["ended_at"].string!, teacher: lessons["teacher"].string, location: lessons["location"].string, lessonsId: lessons["id"].int!, visitors: visitorList))
                }else{
                    continue
                }
            }
            result.append(Schedule(date: date, lessons: lessonsList))
        }
        
        return result
    }
    
    func transformJsonVisitLesson(json: Any) -> [Int]{
        var visitArr = [Int]()
        let json = JSON(json)
        
        UserDefaults.standard.setValue(json["id"].int!, forKey: "user_id")
        
        for (_, visit):(String, JSON) in json["visited_lessons"] {
            visitArr.append(visit.int!)
        }
        return visitArr
    }
    
    func transformJsonFacultyData(json: Any) -> [FacultyGroup]{
        let json = JSON(json)
        var facultyArr = [FacultyGroup]()
        
        for (_, subJson):(String, JSON) in json["results"] {
            for (_, facultyName):(String, JSON) in subJson["faculties"] {
//                faculty.append(facultyName["name"].string!)
                var groupList = [Group]()
                for (_, groupNumber):(String, JSON) in facultyName["groups"] {
                    groupList.append(Group(number: groupNumber["name"].string, id: groupNumber["id"].int))
                }
                facultyArr.append(FacultyGroup(nameFaculty: facultyName["name"].string!, groupArr: groupList.sorted{(s1: Group, s2: Group) -> Bool in return Int(s1.groupNumber!)! < Int(s2.groupNumber!)!} ))

            }
        }
        return facultyArr
    }

}
