//
//  MenuView.swift
//  Schedule
//
//  Created by Влад Бирюков on 15.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation

class MenuView: BaseView{
    var presenter = MenuPresenter()
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var numberGroup: UILabel!
    
    override func viewDidLoad() {
        self.basePresenter = presenter
        presenter.viewToDraw = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    func setUserNameString(userName : String) {
        self.userName.text = userName
    }
    
    func setNumberGroupString(numberGroup : String) {
        self.numberGroup.text = numberGroup
    }
    
}
