//
//  RegistrationViewController.swift
//  Schedule
//
//  Created by Влад Бирюков on 05.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit
import SwiftyButton

class RegistrationViewController: UIViewController {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var userLogin: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var ErrorLabel: UITextField!
    @IBOutlet weak var customButton: UIButton!
    
    var typeRegistration = ""
    private let animation = Animation()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonNext = PressableButton()
        customButton.addSubview(buttonNext)
        
        captionLabel.text = "LOGIN IN \(typeRegistration.uppercased())"
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        NotificationCenter.default.addObserver(self, selector: #selector(RegistrationViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegistrationViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func swiped(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                self.present(animation.animated_transitions(viewIndefiner: "HomeController", duration: 0.7, type: kCATransitionPush, subtype: kCATransitionFromLeft, view: view), animated:false, completion:nil)
            default:
                break
            }
        }
    }
    
    @IBAction func signInAcount(_ sender: UIButton) {
        if (validateFields()){
            
            ErrorLabel.text = "Incorrect login or password"

        }else{
            ErrorLabel.text = "Empty field login or password"
        }
    }
    
    
    private func validateFields() -> Bool {
        if !(userLogin.text!.isEmpty || userPassword.text!.isEmpty) {
            return true
        }
        return false
    }

    
    func keyboardWillShow(notification: NSNotification) {
        if userLogin.isEditing || userPassword.isEditing {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0{
                    self.view.frame.origin.y -= 1*keyboardSize.height/3
                }
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as?  NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += 1*keyboardSize.height/3
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userLogin.resignFirstResponder()
        userPassword.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
