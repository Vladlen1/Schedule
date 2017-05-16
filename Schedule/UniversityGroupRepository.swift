//
//  UniversityGroupRepository.swift
//  Schedule
//
//  Created by Влад Бирюков on 16.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation

import RxSwift

protocol UniversityGroupRepository {
    func getAllFacultyGroup() -> Observable<FacultyGroup>
}
