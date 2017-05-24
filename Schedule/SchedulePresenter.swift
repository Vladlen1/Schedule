//
//  ScheduleListPresenter.swift
//  Schedule
//
//  Created by Влад Бирюков on 12.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class SchedulePresenter : BasePresenter,  UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate{
    

    let emailUser = UserDefaults.standard.value(forKey: "email") as! String

    var baseView = [ScheduleViewModel]()
    var userArr = [UserSchedule]()
    var visitLesson = [Int]()
    
    var scheduleView: ScheduleView!
    
    public func load() {

        getUser()
        getInformVisitLessons()
        getScheduleMapperInform()
        settingLongPress()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    private func getUser() {
        let _ = UserInteractor().exute().subscribe(onNext: {obj in
            self.userArr.append(obj)
        }, onError: {error in
        }, onCompleted: {
            print("Complete")
        }, onDisposed: {
    
        }).addDisposableTo(self.disposeBag)
    }
    
    private func getInformVisitLessons() {
        let _ = VisitLessonInteractor().exute(email: UserDefaults.standard.value(forKey: "email") as! String, firstName: UserDefaults.standard.value(forKey: "user_first_name") as! String, lastName: UserDefaults.standard.value(forKey: "user_last_name") as! String).subscribe(onNext: {obj in
            self.visitLesson.append(obj)
        }, onError: {error in
        }, onCompleted: {
            print("Complete")
        }, onDisposed: {
            
        }).addDisposableTo(self.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.load()
    }
    private func getScheduleMapperInform() {
        for user in userArr {
            if user.email == emailUser && user.activite == true {
                self.scheduleView.startSpinner()
                let _ = ScheduleInteractor().exute(gropId: String(user.idGroup), subgroup: user.subgroup).subscribe(onNext: {arr in
                    self.baseView = ScheduleMapper().tranformScheduleObject(schedules: arr)
                }, onError: {error in
                    self.scheduleView.stopSpinner()
                }, onCompleted: {
                    DispatchQueue.main.async {
                        self.scheduleView.reloadTableView()
                        self.scheduleView.stopSpinner()

                    }
                }, onDisposed: {
                    self.scheduleView.stopSpinner()
                }).addDisposableTo(self.disposeBag)
            }
        }
    }
    
    func settingLongPress() {
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self,action: #selector(SchedulePresenter.longPress(_:)))
        longPressGesture.minimumPressDuration = 1.0
        longPressGesture.delegate = self
        self.scheduleView.tableView.addGestureRecognizer(longPressGesture)
    }
    
    func longPress(_ sender: AnyObject) {
        let longPress:UILongPressGestureRecognizer = sender as! UILongPressGestureRecognizer
        
        if longPress.state == UIGestureRecognizerState.began{
            let location:CGPoint = longPress.location(in: self.scheduleView.tableView) as CGPoint
            if let indexPath = self.scheduleView.tableView.indexPathForRow(at: location){
                print(indexPath.section, indexPath.row)
                creatingCustomAlert(indexPath)
            }
        }
    }
    
    func creatingCustomAlert(_ indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Choice", message: "Will you go to this pair?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            
            let cell = self.scheduleView.tableView.cellForRow(at: indexPath) as! ScheduleTableViewCell
            
            if cell.favoritePair.image != UIImage(named: "highlightedStar") {
                DecideAttendance().decideVisit(type: "visit", userId: UserDefaults.standard.value(forKey: "user_id") as! Int, lessonId: self.baseView[indexPath.section].lessons[indexPath.row].lessonId)
                cell.favoritePair.image = UIImage(named: "highlightedStar")
                var numberOfPeople = Int(cell.numberOfPeople.text!)
                numberOfPeople = numberOfPeople! + 1
                cell.numberOfPeople.text = String(numberOfPeople!)
            }
            
        }
        let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")

            let cell = self.scheduleView.tableView.cellForRow(at: indexPath) as! ScheduleTableViewCell
            
            if cell.favoritePair.image == UIImage(named: "highlightedStar") {
                DecideAttendance().decideVisit(type: "slack", userId: UserDefaults.standard.value(forKey: "user_id") as! Int, lessonId: self.baseView[indexPath.section].lessons[indexPath.row].lessonId)
                
                cell.favoritePair.image = UIImage(named: "emptyStar")
                var numberOfPeople = Int(cell.numberOfPeople.text!)
                numberOfPeople = numberOfPeople! - 1
                cell.numberOfPeople.text = String(numberOfPeople!)
            }
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.scheduleView.scheduleController.present(alertController, animated: true, completion: nil)
    }
    
    
    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.red
    }
    
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return baseView[section].date
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return baseView.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return baseView[section].lessons.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ScheduleTableViewCell
        
                cell.room.text = baseView[indexPath.section].lessons[indexPath.row].location
                cell.numberOfPeople.text = baseView[indexPath.section].lessons[indexPath.row].numberOfPeople
                cell.nameTeacher.text = baseView[indexPath.section].lessons[indexPath.row].nameTeacher
                cell.nameSubject.text = baseView[indexPath.section].lessons[indexPath.row].nameSubject
                cell.typePair.image = baseView[indexPath.section].lessons[indexPath.row].typePair
                cell.timeFinish.text = baseView[indexPath.section].lessons[indexPath.row].timeFinish
                cell.timeStart.text = baseView[indexPath.section].lessons[indexPath.row].timeStart
                cell.favoritePair.image = UIImage(named: "emptyStar")
        
        for lessonId in visitLesson {
            if baseView[indexPath.section].lessons[indexPath.row].lessonId == lessonId {
                cell.favoritePair.image = UIImage(named: "highlightedStar")
            }
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.setValue(baseView[indexPath.section].lessons[indexPath.row].lessonId, forKey: "activite_section")
        
        let nextViewController = self.scheduleView.scheduleController.storyboard?.instantiateViewController(withIdentifier: "VisitStudentController") as! VisitStudentController
        self.scheduleView.scheduleController.navigationController?.pushViewController(nextViewController, animated: true)
    }
}

