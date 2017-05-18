//
//  UserInteractor.swift
//  Schedule
//
//  Created by Влад Бирюков on 15.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import RxSwift

class UserInteractor {
    var userRepository = UserDataRepository()
    
    func exute() ->  Observable<UserSchedule> {
        return userRepository.getAllUserObjects()
    }
}
