//
//  ScheduleListPresenter.swift
//  Schedule
//
//  Created by Влад Бирюков on 12.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation

import RxSwift

public class ScheduleListPresenter : NSObject, Presenter,  UITableViewDataSource, UITableViewDelegate {
    
    
    var baseView : [ScheduleViewModel] = []
    var scheduleController : ScheduleController?

    
    public func willAppear() {
        
    }
    
    public func willDisappear() {
        
    }
    
    public func destroy() {
        
    }
    
    public func initialize()  {
        
        self.scheduleController?.tableView.delegate = self
        self.scheduleController?.tableView.dataSource = self
        
        let _ = ScheduleInteractor().exute().subscribe(onNext: {arr in
            self.baseView = ScheduleMapper().tranformScheduleObject(schedules: arr)
        }, onError: {error in}, onCompleted: { print("Flow completed")
            DispatchQueue.main.async {
                self.scheduleController?.tableView.reloadData()
            }
        }, onDisposed: {})
        

        
    }
    
    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.red
        header.textLabel?.font = UIFont(name: "Futura", size: 17)!
        header.textLabel.
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
                cell.room.text = baseView[indexPath.section].lessons[indexPath.row].location
                cell.numberOfPeople.text = baseView[indexPath.section].lessons[indexPath.row].numberOfPeople
                cell.nameTeacher.text = baseView[indexPath.section].lessons[indexPath.row].nameTeacher
                cell.nameSubject.text = baseView[indexPath.section].lessons[indexPath.row].nameSubject
                cell.typePair.image = baseView[indexPath.section].lessons[indexPath.row].typePair
                cell.timeFinish.text = baseView[indexPath.section].lessons[indexPath.row].timeFinish
                cell.timeStart.text = baseView[indexPath.section].lessons[indexPath.row].timeStart
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        UserDefaults.standard.setValue(getSchedule.items[indexPath.section][indexPath.row].lessonsId, forKey: "activite_section")
        //
        //        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "VisitStudentController") as! VisitStudentController
        //        self.present(nextViewController, animated:true, completion:nil)
        //        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "VisitStudentController") as! VisitStudentController
        //
        //        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    //    func longPress(_ sender: AnyObject) {
    //        let longPress:UILongPressGestureRecognizer = sender as! UILongPressGestureRecognizer
    //
    //        if longPress.state == UIGestureRecognizerState.began{
    //            let location:CGPoint = longPress.location(in: self.tableView) as CGPoint
    //            if let indexPath = self.tableView.indexPathForRow(at: location){
    //                print(indexPath.section, indexPath.row)
    //                createAlert(indexPath)
    //            }
    //        }
    //    }
    
    //    func createAlert(_ indexPath: IndexPath){
    //
    //        let alertController = UIAlertController(title: "Выбор", message: "Ты пойдешь на эту пару?", preferredStyle: .alert)
    //
    //        let okAction = UIAlertAction(title: "Да", style: UIAlertActionStyle.default) {
    //            UIAlertAction in
    //            NSLog("OK Pressed")
    //            self.setVisitUser.decideVisit(type: "visit", userId: UserDefaults.standard.value(forKey: "user_id") as! Int, lessonId: self.getSchedule.items[indexPath.section][indexPath.row].lessonsId)
    //            self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.middle)
    //            let cell = self.tableView.cellForRow(at: indexPath) as! CustomTableViewCell
    //            let res = Int(cell.numberOfPeople.text!)
    //            cell.numberOfPeople.text = String(res! + 1)
    ////            cell.nameSubject.textColor = UIColor.black
    //            self.getUserInfrom()
    //            self.getScheduleInforms()
    //        }
    //        let cancelAction = UIAlertAction(title: "Нет", style: UIAlertActionStyle.cancel) {
    //            UIAlertAction in
    //            NSLog("Cancel Pressed")
    //            self.setVisitUser.decideVisit(type: "slack", userId: UserDefaults.standard.value(forKey: "user_id") as! Int, lessonId: self.getSchedule.items[indexPath.section][indexPath.row].lessonsId)
    //            self.tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    //            let cell = self.tableView.cellForRow(at: indexPath) as! CustomTableViewCell
    //            let res = Int(cell.numberOfPeople.text!)
    //            if res != 0{
    //                cell.numberOfPeople.text = String(res! - 1)
    //            }
    ////            cell.nameSubject.textColor = UIColor.gray
    //            self.getUserInfrom()
    //            self.getScheduleInforms()
    //
    //        }
    //
    //        // Add the actions
    //        alertController.addAction(okAction)
    //        alertController.addAction(cancelAction)
    //
    //        self.present(alertController, animated: true, completion: nil)
    //    }
    
    //    private func getScheduleInforms(){
    //        let schedules = try! Realm().objects(ScheduleGroup.self)
    //        for schedule in schedules{
    //            if schedule.acrivite == true && schedule.email == emailUser{
    //                getSchedule.getDataForScheduleGroup(currentDate: currentDate, groupId: schedule.idGroup, subGroup: schedule.subGroup, completionHandler: {print("kek")
    //                })
    //            }
    //        }
    //    }

    
//    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
//        let header = view as! UITableViewHeaderFooterView
//        header.textLabel?.textColor = UIColor.red
//    }
//    
//    public func numberOfSections(in tableView: UITableView) -> Int {
//        return baseView.count
//    }
//    
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return baseView[section].lessons.count
//    }
//    
//    
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
//        
//        cell.room.text = baseView[indexPath.section].lessons[indexPath.row].location
//        cell.numberOfPeople.text = baseView[indexPath.section].lessons[indexPath.row].numberOfPeople
//        cell.nameTeacher.text = baseView[indexPath.section].lessons[indexPath.row].nameTeacher
//        cell.nameSubject.text = baseView[indexPath.section].lessons[indexPath.row].nameSubject
//        cell.typePair.image = baseView[indexPath.section].lessons[indexPath.row].typePair
//        cell.timeFinish.text = baseView[indexPath.section].lessons[indexPath.row].timeFinish
//        cell.timeStart.text = baseView[indexPath.section].lessons[indexPath.row].timeStart
//        
//        return cell
//    }
}

