//
//  BaseViewController.swift
//  Schedule
//
//  Created by Влад Бирюков on 15.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit
import RxSwift


class BaseViewController: UIViewController, BasePresenterProtocol {
    
    
    let disposeBag = DisposeBag()
    var baseViews : [BaseViewProtocool]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if baseViews != nil{
            for base in baseViews!{
                base.viewWillAppear(animated)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if baseViews != nil{
            for base in baseViews!{
                base.viewDidAppear(animated)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if baseViews != nil{
            for base in baseViews!{
                base.viewWillDisappear(animated)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if baseViews != nil{
            for base in baseViews!{
                base.viewDidDisappear(animated)
            }
        }
    }

}
