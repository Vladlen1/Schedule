//
//  TransformJson.swift
//  Schedule
//
//  Created by Влад Бирюков on 12.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import SwiftyVK

public class TransformJson{
    
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

}
