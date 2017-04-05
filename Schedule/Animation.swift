//
//  Animation.swift
//  Schedule
//
//  Created by Влад Бирюков on 05.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit

class Animation{
    
    func animated_transitions(viewIndefiner: String, duration: Float, type: String, subtype: String, view: UIView) -> UIViewController{
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: viewIndefiner)
        let transition = CATransition()
        transition.duration = CFTimeInterval(duration)
        transition.type = type
        transition.subtype = subtype
        view.window!.layer.add(transition, forKey: kCATransition)
        
        return resultViewController
    }
    
    func animate_swipe(idefiner: String, presentationStyle: Int, transitionStyle: Int ) -> UIViewController{
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: idefiner)
        resultViewController.modalPresentationStyle = UIModalPresentationStyle(rawValue: presentationStyle)!
        resultViewController.modalTransitionStyle = UIModalTransitionStyle(rawValue: transitionStyle)!
        
        return resultViewController
    }
}
