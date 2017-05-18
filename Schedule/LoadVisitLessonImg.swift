//
//  LoadVisitLessonImg.swift
//  Schedule
//
//  Created by Влад Бирюков on 15.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class LoadVisitLessonImpl : LoadVisitLesson {
    func getVisitLessonObject(email: String, firstName: String, lastName: String) -> Observable<Int> {
        return Observable<Int>.create { (observer) -> Disposable in
            let alamofireRequest = Alamofire.request("https://schedule-api-v1.herokuapp.com/api/users/", method: .post, parameters: ["email": email, "first_name": firstName, "last_name": lastName]).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let visitLessons = TransformJson().transformJsonVisitLesson(json: value)
                    if visitLessons.count != 0{
                        for visitLesson in visitLessons {
                            observer.onNext(visitLesson)
                        }
                        observer.onCompleted()
                    } else {
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
