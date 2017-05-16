//
//  UniversityGroupDataRepository.swift
//  Schedule
//
//  Created by Влад Бирюков on 16.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import RxSwift

class UniversityGroupDataRepository: NSObject, UniversityGroupRepository {
    let dataStore = LoadFacultyDataImpl()
    
    func getAllFacultyGroup() -> Observable<FacultyGroup> {
        return self.dataStore.getFacultyData()
    }
}
