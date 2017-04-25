//
//  AddScheduleController.swift
//  Schedule
//
//  Created by Влад Бирюков on 18.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit
import RealmSwift


class AddScheduleController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var university: UITextField!
    @IBOutlet weak var faculty: UITextField!
    @IBOutlet weak var group: UITextField!
    @IBOutlet weak var subgroup: UITextField!
    
    let universityPickerView = UIPickerView()
    let facultyPickerView = UIPickerView()
    let groupPickerView = UIPickerView()
    let subgroupPickerView = UIPickerView()
    
    let getScheduleData = LoadDataForUniversityGroup.sharedInstance
    
    private var scheduleGroup: ScheduleGroup!
    private var groupActive: Group?
    private let animation = Animation()
    private var email = UserDefaults.standard.value(forKey: "email") as! String

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getScheduleData.getDataForUniversityGroup()
        
        universityPickerView.delegate = self
        universityPickerView.tag = 1
        university.inputView = universityPickerView
        
        facultyPickerView.delegate = self
        facultyPickerView.tag = 2
        faculty.inputView = facultyPickerView
        
        groupPickerView.delegate = self
        groupPickerView.tag = 3
        group.inputView = groupPickerView
        
        subgroupPickerView.delegate = self
        subgroupPickerView.tag = 4
        subgroup.inputView = subgroupPickerView
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1 {
            return getScheduleData.university.count
        }else if pickerView.tag == 2{
            return getScheduleData.faculty.count
        }else if pickerView.tag == 4{
            return getScheduleData.subgroup.count
        }else if facultyPickerView.selectedRow(inComponent: 0) == 0 {
            return getScheduleData.group[0].count
        } else if facultyPickerView.selectedRow(inComponent: 0) == 1 {
            return getScheduleData.group[1].count
        }else if facultyPickerView.selectedRow(inComponent: 0) == 2 {
            return getScheduleData.group[2].count
        } else if facultyPickerView.selectedRow(inComponent: 0) == 3 {
            return getScheduleData.group[3].count
        }else if facultyPickerView.selectedRow(inComponent: 0) == 4 {
            return getScheduleData.group[4].count
        } else if facultyPickerView.selectedRow(inComponent: 0) == 5 {
            return getScheduleData.group[5].count
        }else if facultyPickerView.selectedRow(inComponent: 0) == 6 {
            return getScheduleData.group[6].count
        } else if facultyPickerView.selectedRow(inComponent: 0) == 7 {
            return getScheduleData.group[7].count
        }else if facultyPickerView.selectedRow(inComponent: 0) == 8 {
            return getScheduleData.group[8].count
        } else if facultyPickerView.selectedRow(inComponent: 0) == 9 {
            return getScheduleData.group[9].count
        }
        
        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 {
            return getScheduleData.university[row]
        }else if pickerView.tag == 2{
            return getScheduleData.faculty[row]
        }else if pickerView.tag == 4{
            return getScheduleData.subgroup[row]
        }else if facultyPickerView.selectedRow(inComponent: 0) == 0 {
            return getScheduleData.group[0][row].groupNumber
        } else if facultyPickerView.selectedRow(inComponent: 0) == 1 {
            return getScheduleData.group[1][row].groupNumber
        }else if facultyPickerView.selectedRow(inComponent: 0) == 2 {
            return getScheduleData.group[2][row].groupNumber
        } else if facultyPickerView.selectedRow(inComponent: 0) == 3 {
            return getScheduleData.group[3][row].groupNumber
        }else if facultyPickerView.selectedRow(inComponent: 0) == 4 {
            return getScheduleData.group[4][row].groupNumber
        } else if facultyPickerView.selectedRow(inComponent: 0) == 5 {
            return getScheduleData.group[5][row].groupNumber
        }else if facultyPickerView.selectedRow(inComponent: 0) == 6 {
            return getScheduleData.group[6][row].groupNumber
        } else if facultyPickerView.selectedRow(inComponent: 0) == 7 {
            return getScheduleData.group[7][row].groupNumber
        }else if facultyPickerView.selectedRow(inComponent: 0) == 8 {
            return getScheduleData.group[8][row].groupNumber
        } else if facultyPickerView.selectedRow(inComponent: 0) == 9 {
            return getScheduleData.group[9][row].groupNumber
        }
        
        return nil
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1 {
            university.text = getScheduleData.university[row]
        }else if pickerView.tag == 2{
            groupPickerView.reloadAllComponents()
            faculty.text = getScheduleData.faculty[row]
        }else if pickerView.tag == 4{
            subgroup.text = getScheduleData.subgroup[row]
        }else if facultyPickerView.selectedRow(inComponent: 0) == 0 {
            groupActive = getScheduleData.group[0][row]
            group.text = getScheduleData.group[0][row].groupNumber
        } else if facultyPickerView.selectedRow(inComponent: 0) == 1 {
            groupActive = getScheduleData.group[1][row]
            group.text = getScheduleData.group[1][row].groupNumber
        }else if facultyPickerView.selectedRow(inComponent: 0) == 2 {
            groupActive = getScheduleData.group[2][row]
            group.text = getScheduleData.group[2][row].groupNumber
        } else if facultyPickerView.selectedRow(inComponent: 0) == 3 {
            groupActive = getScheduleData.group[3][row]
            group.text = getScheduleData.group[3][row].groupNumber
        }else if facultyPickerView.selectedRow(inComponent: 0) == 4 {
            groupActive = getScheduleData.group[4][row]
            group.text = getScheduleData.group[4][row].groupNumber
        } else if facultyPickerView.selectedRow(inComponent: 0) == 5 {
            groupActive = getScheduleData.group[5][row]
            group.text = getScheduleData.group[5][row].groupNumber
        }else if facultyPickerView.selectedRow(inComponent: 0) == 6 {
            groupActive = getScheduleData.group[6][row]
            group.text = getScheduleData.group[6][row].groupNumber
        } else if facultyPickerView.selectedRow(inComponent: 0) == 7 {
            groupActive = getScheduleData.group[7][row]
            group.text = getScheduleData.group[7][row].groupNumber
        }else if facultyPickerView.selectedRow(inComponent: 0) == 8 {
            groupActive = getScheduleData.group[8][row]
            group.text = getScheduleData.group[8][row].groupNumber
        } else if facultyPickerView.selectedRow(inComponent: 0) == 9 {
            groupActive = getScheduleData.group[9][row]
            group.text = getScheduleData.group[9][row].groupNumber
        }

        self.view.endEditing(true)

    
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 && indexPath.row == 0 {
            
            university.becomeFirstResponder()
            
        }else if indexPath.section == 1 && indexPath.row == 0 {
            
            faculty.becomeFirstResponder()
            
        }else if indexPath.section == 2 && indexPath.row == 0 {
            
            group.becomeFirstResponder()
            
        }else if indexPath.section == 3 && indexPath.row == 0 {
            
            subgroup.becomeFirstResponder()
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    private func addSchedule() -> Bool {
        let realm = try! Realm()

        let schedules = try! Realm().objects(ScheduleGroup.self)
        for schedule in schedules{
            if schedule.acrivite == true && schedule.email == email{
                try! realm.write {
                    schedule.acrivite = false
                }
            }
        }
        
        try! realm.write {
            let newScheduleGroup = ScheduleGroup()
            
            newScheduleGroup.email = email
            newScheduleGroup.groupNumber = (self.groupActive?.groupNumber!)!
            newScheduleGroup.idGroup = (self.groupActive?.groupId!)!
            newScheduleGroup.subGroup = self.subgroup.text!
            newScheduleGroup.acrivite = true
            
            realm.add(newScheduleGroup)
            self.scheduleGroup = newScheduleGroup
        }
        return true
    }
    
    private func validateFields() -> Bool {
        
        if university.text!.isEmpty || faculty.text!.isEmpty ||
            group.text!.isEmpty || subgroup.text!.isEmpty {
            
            
            let alertController = UIAlertController(title: "Validation Error", message: "All fields must be filled", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive) { alert in
                alertController.dismiss(animated: true, completion: nil)
            }
            
            animation.animate_alert(alert: alertController)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            
            return false
            
        } else {
            // To do
            return true

        }
    }
    
    @IBAction func addNewSchedule(_ sender: UIBarButtonItem) {
        if validateFields() {
            if (addSchedule()){
                self.present(animation.animated_transitions(viewIndefiner: "TableViewController", duration: 0.5, type: kCATransitionPush, subtype: kCATransitionFromRight, view: view), animated:false, completion:nil)
            }
        }
    }
    
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        self.present(animation.animated_transitions(viewIndefiner: "TableViewController", duration: 0.5, type: kCATransitionPush, subtype: kCATransitionFromLeft, view: view), animated:false, completion:nil)
    }
    
    func swiped(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                self.present(animation.animated_transitions(viewIndefiner: "TableViewController", duration: 0.7, type: kCATransitionPush, subtype: kCATransitionFromLeft, view: view), animated:false, completion:nil)
                
            default:
                break
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}
