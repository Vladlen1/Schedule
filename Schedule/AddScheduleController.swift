//
//  AddScheduleController.swift
//  Schedule
//
//  Created by Влад Бирюков on 18.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit

class AddScheduleController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var university: UITextField!
    @IBOutlet weak var faculty: UITextField!
    @IBOutlet weak var special: UITextField!
    @IBOutlet weak var group: UITextField!
    @IBOutlet weak var subgroup: UITextField!
    

    var type = ["kek", "kuk", "reks", "meks"]
    var type2 = ["KSIC", "ARH"]
    var type3 = ["IITG", "DFSFGGF"]
    var type4 = ["325345","332432432", "324234234"]
    var type5 = ["1", "2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let universityPickerView = UIPickerView()
        universityPickerView.delegate = self
        universityPickerView.tag = 1
        university.inputView = universityPickerView
        
        let facultyPickerView = UIPickerView()
        facultyPickerView.delegate = self
        facultyPickerView.tag = 2
        faculty.inputView = facultyPickerView
        
        let specialPickerView = UIPickerView()
        specialPickerView.delegate = self
        specialPickerView.tag = 3
        special.inputView = specialPickerView
        
        let groupPickerView = UIPickerView()
        groupPickerView.delegate = self
        groupPickerView.tag = 4
        group.inputView = groupPickerView
        
        let subgroupPickerView = UIPickerView()
        subgroupPickerView.delegate = self
        subgroupPickerView.tag = 5
        subgroup.inputView = subgroupPickerView
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1 {
            return type.count
        }else if pickerView.tag == 2{
            return type2.count
        }else if pickerView.tag == 3{
            return type3.count
        }else if pickerView.tag == 4{
            return type4.count
        }else if pickerView.tag == 5{
            return type5.count
        }
        
        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 {
            return type[row]
        }else if pickerView.tag == 2{
            return type2[row]
        }else if pickerView.tag == 3{
            return type3[row]
        }else if pickerView.tag == 4{
            return type4[row]
        }else if pickerView.tag == 5{
            return type5[row]
        }
        
        return nil
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if pickerView.tag == 1 {
            university.text = type[row]
        }else if pickerView.tag == 2{
            faculty.text = type2[row]
        }else if pickerView.tag == 3{
            special.text = type3[row]
        }else if pickerView.tag == 4{
            group.text = type4[row]
        }else if pickerView.tag == 5{
            subgroup.text = type5[row]
        }

        self.view.endEditing(true)

    
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 && indexPath.row == 0 {
            
            university.becomeFirstResponder()
            
        }else if indexPath.section == 1 && indexPath.row == 0 {
            
            faculty.becomeFirstResponder()
            
        }else if indexPath.section == 2 && indexPath.row == 0 {
            
            special.becomeFirstResponder()
            
        }else if indexPath.section == 3 && indexPath.row == 0 {
            
            group.becomeFirstResponder()
            
        }else if indexPath.section == 4 && indexPath.row == 0 {
            
            subgroup.becomeFirstResponder()
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}
