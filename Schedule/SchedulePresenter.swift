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

class SchedulePresenter : BasePresenter,  UITableViewDataSource, UITableViewDelegate {
    
    private var emailUser = UserDefaults.standard.value(forKey: "email") as! String

    var baseView = [ScheduleViewModel]()
    var userArr = [UserSchedule]()
    var visitLesson = [Int]()
    
    var scheduleController : ScheduleController?

    
//    override func viewWillAppear(_ animated: Bool) {
//        print("Presenter viewwill appear")
//
//    }
//    
//    override func viewDidAppear(_ animated: Bool){
//        
//    }
//    override func viewWillDisappear(_ animated: Bool){
//        
//    }
//    override func viewDidDisappear(_ animated: Bool){
//        
//    }
    
    public func load()  {
        
        self.scheduleController?.tableView.delegate = self
        self.scheduleController?.tableView.dataSource = self

        getUser()
        getScheduleMapperInform()
        settingLongPress()
        settingRevealViewController()
        
        getInformVisitLessons()
    }
    
    
    private func getUser(){
        let _ = UserInteractor().exute().subscribe(onNext: {obj in
            self.userArr.append(obj)
        }, onError: {error in
        }, onCompleted: {
            print("Complete")
        }, onDisposed: {
    
        }).addDisposableTo(self.disposeBag)
    }
    
    
    private func getInformVisitLessons(){
        
        let _ = VisitLessonInteractor().exute(email: UserDefaults.standard.value(forKey: "email") as! String, firstName: UserDefaults.standard.value(forKey: "user_first_name") as! String, lastName: UserDefaults.standard.value(forKey: "user_last_name") as! String).subscribe(onNext: {obj in
            self.visitLesson.append(obj)
        }, onError: {error in
        }, onCompleted: {
            print("Complete")
        }, onDisposed: {
            
        }).addDisposableTo(self.disposeBag)
    }
    
    private func getScheduleMapperInform(){
        
        for user in userArr{
            if user.email == emailUser && user.activite == true{
                self.scheduleController?.spinner.startAnimating()
        
                let _ = ScheduleInteractor().exute(gropId: String(user.idGroup), subgroup: user.subgroup).subscribe(onNext: {arr in
                    self.baseView = ScheduleMapper().tranformScheduleObject(schedules: arr)
                }, onError: {error in
                    self.scheduleController?.spinner.stopAnimating()
                }, onCompleted: {
                    self.scheduleController?.spinner.stopAnimating()
                    DispatchQueue.main.async {
                        self.scheduleController?.tableView.reloadData()
                    }
                }, onDisposed: {
                    self.scheduleController?.spinner.stopAnimating()
                    }).addDisposableTo(self.disposeBag)
            }
        }
    }
    
    private func settingLongPress(){
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self,action: #selector(SchedulePresenter.longPress(_:)))
        longPressGesture.minimumPressDuration = 1.0
        longPressGesture.delegate = self.scheduleController
        self.scheduleController?.tableView.addGestureRecognizer(longPressGesture)
    }
    
    
    func longPress(_ sender: AnyObject) {
        let longPress:UILongPressGestureRecognizer = sender as! UILongPressGestureRecognizer
        
        if longPress.state == UIGestureRecognizerState.began{
            let location:CGPoint = longPress.location(in: self.scheduleController!.tableView) as CGPoint
            if let indexPath = self.scheduleController?.tableView.indexPathForRow(at: location){
                print(indexPath.section, indexPath.row)
                creatingCustomAlert(indexPath)
            }
        }
    }
    
    func creatingCustomAlert(_ indexPath: IndexPath){
        
        let alertController = UIAlertController(title: "Выбор", message: "Ты пойдешь на эту пару?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Да", style: UIAlertActionStyle.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            
            DecideAttendance().decideVisit(type: "visit", userId: UserDefaults.standard.value(forKey: "user_id") as! Int, lessonId: self.baseView[indexPath.section].lessons[indexPath.row].lessonId)
            self.scheduleController?.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.middle)
            let cell = self.scheduleController?.tableView.cellForRow(at: indexPath) as! ScheduleTableViewCell
            var numberOfPeople = Int(cell.numberOfPeople.text!)
            numberOfPeople = numberOfPeople! + 1
            cell.numberOfPeople.text = String(numberOfPeople!)
            
        }
        let cancelAction = UIAlertAction(title: "Нет", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
            DecideAttendance().decideVisit(type: "slack", userId: UserDefaults.standard.value(forKey: "user_id") as! Int, lessonId: self.baseView[indexPath.section].lessons[indexPath.row].lessonId)
            
            self.scheduleController?.tableView.deselectRow(at: indexPath as IndexPath, animated: true)
            let cell = self.scheduleController?.tableView.cellForRow(at: indexPath) as! ScheduleTableViewCell
            var numberOfPeople = Int(cell.numberOfPeople.text!)
            if numberOfPeople != 0{
                numberOfPeople = numberOfPeople! - 1
                cell.numberOfPeople.text = String(numberOfPeople!)
            }

            
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.scheduleController?.present(alertController, animated: true, completion: nil)
    }
    
    private func settingRevealViewController(){
        if self.scheduleController?.revealViewController() != nil {
            self.scheduleController?.revealViewController().rearViewRevealWidth = 210
            self.scheduleController?.menuButton.target = self.scheduleController?.revealViewController()
            self.scheduleController?.menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.scheduleController?.view.addGestureRecognizer((self.scheduleController?.revealViewController().panGestureRecognizer())!)
        }
    }

    
    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
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
        
        for lessonId in visitLesson {
            if baseView[indexPath.section].lessons[indexPath.row].lessonId == lessonId {
                self.scheduleController?.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.middle)
            }
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                UserDefaults.standard.setValue(baseView[indexPath.section].lessons[indexPath.row].lessonId, forKey: "activite_section")
        let vc = self.scheduleController?.storyboard?.instantiateViewController(withIdentifier: "VisitStudentController")
        self.scheduleController?.present(vc!, animated: true, completion: nil)
    }

}
