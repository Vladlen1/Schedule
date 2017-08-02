//
//  VisitLessonInteractor.swift
//  Schedule
//
//  Created by Влад Бирюков on 15.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import RxSwift

class VisitLessonInteractor {
    
    var visitLessonDataRepository = VisitLessonDataRepository()
    
    func execute(email: String, firstName: String, lastName: String) -> Observable<Int> {
        return visitLessonDataRepository.getAllVisitLesson(email : email, firstName: firstName, lastName: lastName)
    }
        
}
