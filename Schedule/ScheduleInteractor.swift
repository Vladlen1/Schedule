//
//  ScheduleInteractor.swift
//  Schedule
//
//  Created by Влад Бирюков on 12.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import RxSwift

class ScheduleInteractor {
    
    var scheduleRepositiory = ScheduleDataRepository()
    
    func exute(gropId: String, subgroup: String) -> Observable<[Schedule]> {
        return scheduleRepositiory.getAllScheduleObjects(groupID : gropId, date : getCurrentDate(), subgroup: subgroup)
    }
    
    private func getCurrentDate() -> String {
        let formatter = DateFormatter()
        var currentDate = String()
        formatter.dateFormat = "yyyy-MM-dd"
        currentDate = formatter.string(from: Date())
        return currentDate
    }
    
}
