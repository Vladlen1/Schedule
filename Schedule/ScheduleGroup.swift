//
//  ScheduleGroup.swift
//  Schedule
//
//  Created by Влад Бирюков on 25.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import RealmSwift

class ScheduleGroup: Object{
    dynamic var email = ""
    dynamic var groupNumber = ""
    dynamic var idGroup = 1
    dynamic var subGroup = ""
    dynamic var acrivite = false
}
