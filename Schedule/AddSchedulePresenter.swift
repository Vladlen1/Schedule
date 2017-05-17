//
//  AddSchedulePresenter.swift
//  Schedule
//
//  Created by Влад Бирюков on 16.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import RealmSwift

class AddSchedulePresenter: BasePresenter, UITableViewDelegate,UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    
    let email = UserDefaults.standard.value(forKey: "email") as! String
    let nameUniversity = ["БГУИР"]
    let nameSubGroup = ["1", "2"]
    var facultyGroup = [FacultyGroup]()
    var addScheduleController: AddScheduleController?
    var nameFaculty = [String]()
    var nameGroup = [[Group]]()
    var currentTag = 0
    var pickerView = UIPickerView()
    var pickerArr = [String]()
    
    let animation = Animation()

    
    func load(){
        
        settingTextField()
        settingPickerView()

        facultyGroupData()
    }
    
    private func settingTextField(){
        
        self.addScheduleController?.university.tag = 1
        self.addScheduleController?.faculty.tag = 2
        self.addScheduleController?.group.tag = 3
        self.addScheduleController?.subgroup.tag = 4
        
        self.addScheduleController?.university.delegate = self
        self.addScheduleController?.faculty.delegate = self
        self.addScheduleController?.group.delegate = self
        self.addScheduleController?.subgroup.delegate = self
    }
    
    private func settingPickerView(){
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        self.addScheduleController?.university.inputView = pickerView
        self.addScheduleController?.faculty.inputView = pickerView
        self.addScheduleController?.group.inputView = pickerView
        self.addScheduleController?.subgroup.inputView = pickerView
    }
    
    private func facultyGroupData(){
        let _ = UniversityGroupInteractor().exute().subscribe(onNext: {obj in
            self.facultyGroup.append(obj)
            self.nameFaculty.append(obj.nameFaculty)
            self.nameGroup.append(obj.groupArr)
        }, onError: {error in
        }, onCompleted: {
            print("Complete")
        }, onDisposed: {
            
        }).addDisposableTo(self.disposeBag)

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if currentTag == 1{
            self.addScheduleController?.university.text = pickerArr[row]
        } else if currentTag == 2{
            self.addScheduleController?.faculty.text = pickerArr[row]
        } else if currentTag == 3{
            self.addScheduleController?.group.text = pickerArr[row]
        } else if currentTag == 4{
            self.addScheduleController?.subgroup.text = pickerArr[row]
        }
        self.addScheduleController?.view.endEditing(true)

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArr[row]
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerArr.removeAll()
        
        if textField.tag == 1 {
            currentTag = 1
            
            self.pickerArr = nameUniversity
            pickerView.reloadAllComponents()
        } else if textField.tag == 2{
            currentTag = 2
            
            if self.addScheduleController?.group.text != ""{
                for faculty in facultyGroup{
                    for group in faculty.groupArr{
                        if group.groupNumber == self.addScheduleController?.group.text{
                            self.pickerArr = [faculty.nameFaculty]
                            break
                        }
                    }
                }
            }else{
                self.pickerArr = nameFaculty
            }

            pickerView.reloadAllComponents()
        } else if textField.tag == 3{
            currentTag = 3
            
            if self.addScheduleController?.faculty.text != ""{
                for faculty in facultyGroup{
                    if faculty.nameFaculty == self.addScheduleController?.faculty.text{
                        for group in faculty.groupArr{
                            self.pickerArr.append(group.groupNumber!)
                        }
                    }
                }

            }else{
                for groupFaculty in nameGroup{
                    for group in groupFaculty{
                        self.pickerArr.append(group.groupNumber!)
                    }
                }
            }
            pickerView.reloadAllComponents()
        }else if textField.tag == 4{
            currentTag = 4
            
            self.pickerArr = nameSubGroup
            pickerView.reloadAllComponents()
        }
    }
    
    private func validateFields() -> Bool {
        
        if (self.addScheduleController?.university.text!.isEmpty)! || (self.addScheduleController?.faculty.text!.isEmpty)! ||
            (self.addScheduleController?.group.text!.isEmpty)! || (self.addScheduleController?.subgroup.text!.isEmpty)! {
            
            
            let alertController = UIAlertController(title: "Validation Error", message: "All fields must be filled", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive) { alert in
                alertController.dismiss(animated: true, completion: nil)
            }
            
            animation.animate_alert(alert: alertController)
            alertController.addAction(alertAction)
            self.addScheduleController?.present(alertController, animated: true, completion: nil)
            
            return false
            
        } else {
            return true
            
        }
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
            newScheduleGroup.groupNumber = (self.addScheduleController?.group.text)!

            
            newScheduleGroup.idGroup = getIdGroup()
            newScheduleGroup.subGroup = (self.addScheduleController?.subgroup.text!)!
            newScheduleGroup.acrivite = true
            
            realm.add(newScheduleGroup)
        }
        return true
    }
    
    func addNewSchedule(){
        if validateFields() {
            if (addSchedule()){
                let vc = self.addScheduleController?.storyboard?.instantiateViewController(withIdentifier: "TableViewController")
                self.addScheduleController?.present(vc!, animated: true, completion: nil)
            }
        }
    }
    
    private func getIdGroup() -> Int{
        var idGroup = 0
        for groups in nameGroup{
            for group in groups{
                if self.addScheduleController?.group.text == group.groupNumber{
                    idGroup = group.groupId!
                    break
                }
            }
        }
        return idGroup
    }
    
    func cancel(){
        let vc = self.addScheduleController?.storyboard?.instantiateViewController(withIdentifier: "TableViewController")
        self.addScheduleController?.present(vc!, animated: true, completion: nil)
    }

}
