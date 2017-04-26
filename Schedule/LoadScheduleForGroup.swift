//
//  LoadScheduleForGroup.swift
//  Schedule
//
//  Created by Влад Бирюков on 25.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoadScheduleForGroup {
    
    static let sharedInstance = LoadScheduleForGroup()
    
    private init() {}
    
    var section = [String]()
    var items = [[Lesson]]()
    
    func getDataForScheduleGroup(currentDate: String, groupId: Int, subGroup: String, completionHandler: @escaping () -> Void){
        Alamofire.request("https://schedule-api-v1.herokuapp.com/api/schedule/?date_from=\(currentDate)&date_to=2017-05-26&group_id=\(groupId)").responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.section.removeAll()
                self.items.removeAll()
                self.getDataScheduleGroupFromJson(json: json, subgroup: subGroup)
                completionHandler()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func getDataScheduleGroupFromJson(json: JSON, subgroup: String){
        
        for (_, subJson):(String, JSON) in json["results"] {
            section.append(subJson["date"].string!)
            var lessonsList = [Lesson]()
            for (_, lessons):(String, JSON) in subJson["lessons"] {
                var visitorList = [Visitor]()
                for (_, visitors):(String, JSON) in lessons["visitors"]{

                    visitorList.append(Visitor(email: visitors["email"].string, firstName: visitors["first_name"].string!, lastName: visitors["last_name"].string!, userId: visitors["id"].int))
                }

                if subgroup == lessons["note"].string || lessons["note"].string == ""{
                    lessonsList.append(Lesson(name: lessons["name"].string, type: lessons["type"].int!, note: lessons["note"].string, beginAt: lessons["time"]["beginning_at"].string!, endAt: lessons["time"]["ended_at"].string!, teacher: lessons["teacher"].string, location: lessons["location"].string, lessonsId: lessons["id"].int!, visitors: visitorList))
                }else{
                    continue
                }
            }
            items.append(lessonsList)
        }

        
    }
}
