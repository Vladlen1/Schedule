//
//  ScheduleController.swift
//  Schedule
//
//  Created by Влад Бирюков on 14.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit
import RealmSwift

class ScheduleController: UIViewController{

    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    private var emailUser = UserDefaults.standard.value(forKey: "email") as! String

    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    let getSchedule = LoadScheduleForGroup.sharedInstance
    let setUserInform = WorkWithUserVisitedController.sharedInstance
    let setVisitUser = DecideVisitLesson.sharedInstance
    let date = Date()
    let formatter = DateFormatter()
    var currentDate = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        getCurrentDate()
        menuSegue()
        longPress()
        getScheduleInform()
        getUserInfrom()
        
//         print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    private func getCurrentDate(){
        formatter.dateFormat = "yyyy-MM-dd"
        currentDate = formatter.string(from: date)
    }
    
    private func menuSegue(){
        if self.revealViewController() != nil {
            revealViewController().rearViewRevealWidth = 210
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    private func longPress(){
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ScheduleController.longPress(_:)))
        longPressGesture.minimumPressDuration = 1.0
        longPressGesture.delegate = self
        self.tableView.addGestureRecognizer(longPressGesture)
    }
    
    private func getScheduleInform(){
        let schedules = try! Realm().objects(ScheduleGroup.self)
        for schedule in schedules{
            if schedule.acrivite == true && schedule.email == emailUser{
                spinner.startAnimating()
                getSchedule.getDataForScheduleGroup(currentDate: currentDate, groupId: schedule.idGroup, subGroup: schedule.subGroup, completionHandler: {self.tableView.reloadData()
                    self.spinner.stopAnimating()
                })
            }
        }
    }
    
    private func getUserInfrom(){
        self.setUserInform.setUserInformation(email: UserDefaults.standard.value(forKey: "email") as! String, firstName: UserDefaults.standard.value(forKey: "user_first_name") as! String, lastName: UserDefaults.standard.value(forKey: "user_last_name") as! String)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let schedules = try! Realm().objects(ScheduleGroup.self)
        for schedule in schedules{
            if schedule.acrivite == true && schedule.email == emailUser{
              self.title = "\(schedule.groupNumber)/\(schedule.subGroup)"

            }
        }
    }

     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return getSchedule.section[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.red
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return getSchedule.section.count
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getSchedule.items[section].count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        cell.nameSubject.text = getSchedule.items[indexPath.section][indexPath.row].name
        cell.timeStart.text = getSchedule.items[indexPath.section][indexPath.row].beginAt
        cell.timeFinish.text = getSchedule.items[indexPath.section][indexPath.row].endAt
        cell.nameTeacher.text = getSchedule.items[indexPath.section][indexPath.row].teacher
        cell.room.text = getSchedule.items[indexPath.section][indexPath.row].location
        cell.numberOfPeople.text = "\(getSchedule.items[indexPath.section][indexPath.row].visitors.count as Any)"
        if getSchedule.items[indexPath.section][indexPath.row].type == 1 {
            cell.typePair.image = UIImage(named: "green")
        }else if getSchedule.items[indexPath.section][indexPath.row].type == 2{
            cell.typePair.image = UIImage(named: "red")
        }else{
            cell.typePair.image = UIImage(named: "yellow")

        }
        
        for lessonId in setUserInform.visitArr{
            if getSchedule.items[indexPath.section][indexPath.row].lessonsId == lessonId{
                self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.middle)
            }
        }
        
//        for lessonId in setUserInform.unvisitArr{
//            if getSchedule.items[indexPath.section][indexPath.row].lessonsId == lessonId{
//                cell.nameSubject.textColor = UIColor.gray
//            }
//        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.setValue(getSchedule.items[indexPath.section][indexPath.row].lessonsId, forKey: "activite_section")

        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "VisitStudentController") as! VisitStudentController
        self.present(nextViewController, animated:true, completion:nil)
//        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "VisitStudentController") as! VisitStudentController
//        
//        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func longPress(_ sender: AnyObject) {
        let longPress:UILongPressGestureRecognizer = sender as! UILongPressGestureRecognizer
        
        if longPress.state == UIGestureRecognizerState.began{
            let location:CGPoint = longPress.location(in: self.tableView) as CGPoint
            if let indexPath = self.tableView.indexPathForRow(at: location){
                print(indexPath.section, indexPath.row)
                createAlert(indexPath)
            }
        }
    }
    
    func createAlert(_ indexPath: IndexPath){
        
        let alertController = UIAlertController(title: "Выбор", message: "Ты пойдешь на эту пару?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Да", style: UIAlertActionStyle.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            self.setVisitUser.decideVisit(type: "visit", userId: UserDefaults.standard.value(forKey: "user_id") as! Int, lessonId: self.getSchedule.items[indexPath.section][indexPath.row].lessonsId)
            self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.middle)
            let cell = self.tableView.cellForRow(at: indexPath) as! CustomTableViewCell
            let res = Int(cell.numberOfPeople.text!)
            cell.numberOfPeople.text = String(res! + 1)
//            cell.nameSubject.textColor = UIColor.black
            self.getUserInfrom()
            self.getScheduleInforms()
        }
        let cancelAction = UIAlertAction(title: "Нет", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
            self.setVisitUser.decideVisit(type: "slack", userId: UserDefaults.standard.value(forKey: "user_id") as! Int, lessonId: self.getSchedule.items[indexPath.section][indexPath.row].lessonsId)
            self.tableView.deselectRow(at: indexPath as IndexPath, animated: true)
            let cell = self.tableView.cellForRow(at: indexPath) as! CustomTableViewCell
            let res = Int(cell.numberOfPeople.text!)
            if res != 0{
                cell.numberOfPeople.text = String(res! - 1)
            }
//            cell.nameSubject.textColor = UIColor.gray
            self.getUserInfrom()
            self.getScheduleInforms()

        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func getScheduleInforms(){
        let schedules = try! Realm().objects(ScheduleGroup.self)
        for schedule in schedules{
            if schedule.acrivite == true && schedule.email == emailUser{
                getSchedule.getDataForScheduleGroup(currentDate: currentDate, groupId: schedule.idGroup, subGroup: schedule.subGroup, completionHandler: {print("kek")
                })
            }
        }
    }

}

extension ScheduleController:   UITableViewDataSource, UITableViewDelegate,  UITextFieldDelegate, UIGestureRecognizerDelegate, UISearchBarDelegate{

}
