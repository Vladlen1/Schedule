//
//  LoadScheduleImpl.swift
//  Schedule
//
//  Created by Влад Бирюков on 12.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class LoadScheduleImpl : LoadSchedule {
    func getScheduleObject(date : String, groupID : String, subgroup: String) -> Observable<[Schedule]> {
        return Observable<[Schedule]>.create { (observer) -> Disposable in
            let alamofireRequest = Alamofire.request("https://schedule-api-v1.herokuapp.com/api/schedule/?date_from=\(date)&date_to=2017-05-26&group_id=\(groupID)").validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let day = TransformJson().transformJsonScheduleObject(json: value, subgroup: subgroup)
                    observer.onNext(day)
                    observer.onCompleted()
                    
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
