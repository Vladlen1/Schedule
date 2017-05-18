//
//  LoadSchedule.swift
//  Schedule
//
//  Created by Влад Бирюков on 12.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import RxSwift

protocol LoadSchedule {
    func getScheduleObject(date : String, groupID : String, subgroup: String) -> Observable<[Schedule]>;
}
