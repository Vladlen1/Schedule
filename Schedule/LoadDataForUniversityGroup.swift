//
//  LoadDataForUniversityGroup.swift
//  Schedule
//
//  Created by Влад Бирюков on 25.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoadDataForUniversityGroup {
    
    static let sharedInstance = LoadDataForUniversityGroup()
    
    private init() {}
    
    var university = ["БГУИР"]
    var faculty = [String]()
    var group = [[Group]]()
    var subgroup = ["1", "2"]
    
    
    func getDataForUniversityGroup(){
        
        Alamofire.request("https://schedule-api-v1.herokuapp.com/api/university/").responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.getDataForUniversityGroupFromJson(json: json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func getDataForUniversityGroupFromJson(json: JSON){

        for (_, subJson):(String, JSON) in json["results"] {
            for (_, facultyName):(String, JSON) in subJson["faculties"] {
                faculty.append(facultyName["name"].string!)
                var groupList = [Group]()
                for (_, groupNumber):(String, JSON) in facultyName["groups"] {
                    groupList.append(Group(number: groupNumber["name"].string, id: groupNumber["id"].int))
                }
                self.group.append(groupList)
            }
        }
        
    }
}
