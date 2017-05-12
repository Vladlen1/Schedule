//
//  ScheduleInteractor.swift
//  Schedule
//
//  Created by Влад Бирюков on 12.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import RxSwift

public class ScheduleInteractor {
    
    var scheduleRepositiory = ScheduleDataRepository()
    
    func exute() -> Observable<[Schedule]> {
        return scheduleRepositiory.getAllScheduleObjects(groupID : "dsf", date : "sdf", subgroup: "2")
            
//            .flatMap{schedule -> Observable<String> in
//            if schedule.date != nil {
//                return Observable.just(schedule.date!)
//            } else {
//                
//                return Observable.just("Error")
//            }
//            
        }
}
