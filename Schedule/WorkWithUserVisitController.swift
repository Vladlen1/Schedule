//
//  WorkWithUserVisitController.swift
//  Schedule
//
//  Created by Влад Бирюков on 26.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

class WorkWithUserVisitedController {
    
    static let sharedInstance = WorkWithUserVisitedController()
    
    var visitArr = [Int]()
    var unvisitArr = [Int]()
    
    private init() {}
    
    
    
    func setUserInformation(email: String, firstName: String, lastName: String){
        
        Alamofire.request("https://schedule-api-v1.herokuapp.com/api/users/", method: .post, parameters: ["email": email, "first_name": firstName, "last_name": lastName]).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.visitArr.removeAll()
                self.unvisitArr.removeAll()
                self.getUserId(json: json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func getUserId(json: JSON){
        UserDefaults.standard.setValue(json["id"].int!, forKey: "user_id")

        for (_, visit):(String, JSON) in json["visited_lessons"] {
            visitArr.append(visit.int!)
        }
        
        for (_, unvisit):(String, JSON) in json["unvisited_lessons"] {
            unvisitArr.append(unvisit.int!)
        }
        
    }
}
