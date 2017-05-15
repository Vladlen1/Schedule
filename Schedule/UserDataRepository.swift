//
//  File.swift
//  Schedule
//
//  Created by Влад Бирюков on 15.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import RxSwift

public class UserDataRepository: NSObject, UserRepository{
    let dataStore = LoadUserImpl()
    
    public func getAllUserObjects() -> Observable<UserSchedule> {
        return self.dataStore.getUserObject()
    }

}
