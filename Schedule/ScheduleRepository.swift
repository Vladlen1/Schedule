//
//  ScheduleRepository.swift
//  Schedule
//
//  Created by Влад Бирюков on 12.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import RxSwift

public protocol ScheduleRepository {
    func getAllScheduleObjects(groupID : String, date : String, subgroup: String) -> Observable<[Schedule]>
}
