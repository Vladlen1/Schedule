//
//  LoadUser.swift
//  Schedule
//
//  Created by Влад Бирюков on 15.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import RxSwift

public protocol LoadUser{
    func getUserObject() -> Observable<UserSchedule>
}
