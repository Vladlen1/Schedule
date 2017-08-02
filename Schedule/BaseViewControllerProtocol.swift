//
//  BaseViewControllerProtocol.swift
//  Schedule
//
//  Created by Влад Бирюков on 25.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation

protocol BaseViewControllerProtocol {
    func viewWillAppear(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func viewDidDisappear(_ animated: Bool)
}
