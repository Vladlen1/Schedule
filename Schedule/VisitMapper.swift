//
//  VisitMapper.swift
//  Schedule
//
//  Created by Влад Бирюков on 15.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation

class VisitMapper {
    
    let activitySectionId = UserDefaults.standard.value(forKey: "activite_section") as! Int

    
    func transformVisitObject(schedules: [Schedule]) -> [VisitViewModel] {
        
        var resultVisitPeople = [VisitViewModel]()
    
        for day in schedules{
            for lesson in day.lessons!{
                if lesson?.lessonsId == activitySectionId{
                    for visit in (lesson?.visitors)!{
                        resultVisitPeople.append(VisitViewModel(firstName: visit.firstName, lastName: visit.lastName))
                    }
                }
            }
        }
        return resultVisitPeople
    }

}
