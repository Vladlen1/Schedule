//
//  BasePresenter.swift
//  Schedule
//
//  Created by Влад Бирюков on 15.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import RxSwift

class BasePresenter: NSObject, BasePresenterProtocol {
    var disposeBag = DisposeBag()
    
    func viewWillAppear(_ animated: Bool) {}
    func viewDidAppear(_ animated: Bool) {}
    func viewWillDisappear(_ animated: Bool) {}
    func viewDidDisappear(_ animated: Bool) {
        self.disposeBag = DisposeBag()
    }
}
