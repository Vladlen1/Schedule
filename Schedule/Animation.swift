//
//  Animation.swift
//  Schedule
//
//  Created by Влад Бирюков on 05.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit
import Jelly


class Animation{
    
    func animate_alert(alert: UIAlertController){
        let customPresentation = JellySlideInPresentation(dismissCurve: .linear,
                                                          presentationCurve: .linear,
                                                          cornerRadius: 15,
                                                          backgroundStyle: .blur(effectStyle: .light),
                                                          jellyness: .jellier,
                                                          duration: .slow,
                                                          directionShow: .top,
                                                          directionDismiss: .bottom,
                                                          widthForViewController: .fullscreen,
                                                          heightForViewController: .fullscreen,
                                                          horizontalAlignment: .center,
                                                          verticalAlignment: .center,
                                                          marginGuards: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10),
                                                          corners: [.topLeft,.bottomRight])
        let jellyAnimator = JellyAnimator(presentation: customPresentation)
        jellyAnimator.prepare(viewController: alert)
        
    }

}
