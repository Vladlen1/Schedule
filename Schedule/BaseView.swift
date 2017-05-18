//
//  BaseView.swift
//  Schedule
//
//  Created by Влад Бирюков on 15.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation

class BaseView: UIView, BaseViewProtocool {
    
    var basePresenter: BasePresenterProtocol?
    
    public func viewDidLoad() {
        
    }
    public func viewWillAppear(_ animated: Bool) {
        if self.basePresenter != nil{
            self.basePresenter?.viewWillAppear(animated)
        }
    }
    
    public func viewDidAppear(_ animated: Bool) {
        if self.basePresenter != nil{
            self.basePresenter?.viewDidAppear(animated)
        }
    }
    
    public func viewWillDisappear(_ animated: Bool) {
        if self.basePresenter != nil {
            self.basePresenter?.viewWillDisappear(animated)
        }
    }
    
    public func viewDidDisappear(_ animated: Bool) {
        if self.basePresenter != nil {
            self.basePresenter?.viewDidDisappear(animated)
        }
    }
}
