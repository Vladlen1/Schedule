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
    
    func getDataForScheduleGroup(currentDate: String, groupId: String){
        
        Alamofire.request("https://schedule-api-v1.herokuapp.com/api/schedule/?date_from=2017-04-25&date_to=2017-05-26&group_id=377").responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.getDataScheduleGroupFromJson(json: json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func getDataScheduleGroupFromJson(json: JSON){
        
        for (_, subJson):(String, JSON) in json["results"] {
            section.append(subJson["date"].string!)
            var lessonsList = [Lesson]()
            for (_, lessons):(String, JSON) in subJson["lessons"] {
                lessonsList.append(Lesson(name: lessons["name"].string, type: lessons["type"].int!, note: lessons["note"].string, beginAt: lessons["time"]["beginning_at"].string!, endAt: lessons["time"]["ended_at"].string!, teacher: lessons["teacher"].string, location: lessons["location"].string))
            }
            items.append(lessonsList)
        }

        
    }
}
