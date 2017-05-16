//
//  UniversityGroupInteractor.swift
//  Schedule
//
//  Created by Влад Бирюков on 16.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import RxSwift

class UniversityGroupInteractor{

     var universityGroupDataRepository = UniversityGroupDataRepository()
    
    func exute() -> Observable<FacultyGroup> {
        return universityGroupDataRepository.getAllFacultyGroup()
    }
}
