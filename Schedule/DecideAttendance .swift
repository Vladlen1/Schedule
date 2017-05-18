//
//  DecideAttendance .swift
//  Schedule
//
//  Created by Влад Бирюков on 15.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import Alamofire

class DecideAttendance{
    func decideVisit(type: String, userId: Int, lessonId: Int) {
        Alamofire.request("https://schedule-api-v1.herokuapp.com/api/users/\(userId)/\(type)/", method: .post, parameters: ["lesson_id": lessonId]).responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
