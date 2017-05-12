//
//  Presenter.swift
//  Schedule
//
//  Created by Влад Бирюков on 12.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation

public protocol Presenter {
    func willAppear()
    func willDisappear()
    func destroy()
}
