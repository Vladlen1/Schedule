//
//  LoadFacultyData.swift
//  Schedule
//
//  Created by Влад Бирюков on 16.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import RxSwift

protocol LoadFacultyData {
    func getFacultyData() -> Observable<FacultyGroup>
}
