//
//  LoadSchedule.swift
//  Schedule
//
//  Created by Влад Бирюков on 12.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import RxSwift

public protocol LoadSchedule{
    func schedule(date : String, groupID : String, subgroup: String) -> Observable<[Schedule]>;
}
