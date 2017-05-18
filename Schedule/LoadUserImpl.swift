//
//  LoadUserImpl.swift
//  Schedule
//
//  Created by Влад Бирюков on 15.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift


class LoadUserImpl: LoadUser {
    func getUserObject() -> Observable<UserSchedule> {
        let users = try! Realm().objects(ScheduleGroup.self)
        
        
        return Observable<UserSchedule>.create{(observer) -> Disposable in
            if users.count != 0 {
                for user in users {
                    observer.onNext(UserSchedule(email: user.email, groupNumber: user.groupNumber, idGroup: user.idGroup, subgroup: user.subGroup, activite: user.acrivite))
                }
                observer.onCompleted()
            } else {
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
