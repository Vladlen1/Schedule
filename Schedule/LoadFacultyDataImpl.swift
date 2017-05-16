//
//  LoadFacultyDataImpl.swift
//  Schedule
//
//  Created by Влад Бирюков on 16.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class LoadFacultyDataImpl: LoadFacultyData{
    func getFacultyData() -> Observable<FacultyGroup>{
        return Observable<FacultyGroup>.create { (observer) -> Disposable in
            let alamofireRequest = Alamofire.request("https://schedule-api-v1.herokuapp.com/api/university/").responseJSON { response in
                switch response.result {
                case .success(let value):
                    let facultys = TransformJson().transformJsonFacultyData(json: value)
                    if facultys.count != 0{
                        for faculty in facultys {
                            observer.onNext(faculty)
                        }
                        observer.onCompleted()
                    }else {
                        observer.onCompleted()
                    }
                case .failure(let error):
                    observer.onError(error)
                    
                }
                
            }
            
            return Disposables.create {
                alamofireRequest.cancel()
            }
    
    }

    }
}
