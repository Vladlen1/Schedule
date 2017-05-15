//
//  AuthenticationView.swift
//  Schedule
//
//  Created by Влад Бирюков on 15.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation

class AuthenticationView: BaseView{
    var presenter = AuthenticationPresenter()
    
    override func viewDidLoad() {
        self.basePresenter = presenter
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}
