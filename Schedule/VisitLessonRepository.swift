//
//  VisitLessonRepository.swift
//  Schedule
//
//  Created by Влад Бирюков on 15.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation

import RxSwift

protocol VisitLessonRepository {
    func getAllVisitLesson(email: String, firstName: String, lastName: String) -> Observable<Int>
}
