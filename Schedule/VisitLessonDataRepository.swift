//
//  VisitLessonDataRepository.swift
//  Schedule
//
//  Created by Влад Бирюков on 15.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import RxSwift

public class VisitLessonDataRepository: NSObject, VisitLessonRepository{
    let dataStore = LoadVisitLessonImpl()
    
    public func getAllVisitLesson(email: String, firstName: String, lastName: String) -> Observable<Int> {
        return self.dataStore.getVisitLessonObject(email: email, firstName: firstName, lastName: firstName)
    }
    
}
