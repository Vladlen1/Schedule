//
//  ScheduleDataRepository.swift
//  Schedule
//
//  Created by Влад Бирюков on 12.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import RxSwift

public class ScheduleDataRepository :NSObject , ScheduleRepository {
    let dataStore = LoadScheduleImpl()
        
    public func getAllScheduleObjects(groupID : String, date : String, subgroup: String) -> Observable<[Schedule]> {
        return self.dataStore.getScheduleObject(date: date, groupID: groupID, subgroup: subgroup)
    }
}
