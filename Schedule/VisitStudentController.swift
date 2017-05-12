////
////  VisitStidentController.swift
////  Schedule
////
////  Created by Влад Бирюков on 20.04.17.
////  Copyright © 2017 Влад Бирюков. All rights reserved.
////
//
//import UIKit
//import RealmSwift
//
//class VisitStudentController: UITableViewController{
//    
//    private let animation = Animation()
//    
//    let getSchedule = LoadScheduleForGroup.sharedInstance
//    private var emailUser = UserDefaults.standard.value(forKey: "email") as! String
//    private var activitySectionId = UserDefaults.standard.value(forKey: "activite_section") as! Int
//    let date = Date()
//    let formatter = DateFormatter()
//    var currentDate = String()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        settingRefresh()
//        settingSwipe()
//        getCurrentDate()
//        getScheduleInform()
//
//    }
//    
//    private func getCurrentDate(){
//        self.title = "Студенты"
//        formatter.dateFormat = "yyyy-MM-dd"
//        currentDate = formatter.string(from: date)
//    }
//    
//    private func getScheduleInform(){
//        let schedules = try! Realm().objects(ScheduleGroup.self)
//        for schedule in schedules{
//            if schedule.acrivite == true && schedule.email == emailUser{
//                getSchedule.getDataForScheduleGroup(currentDate: currentDate, groupId: schedule.idGroup, subGroup: schedule.subGroup, completionHandler: {self.tableView.reloadData()
//                })
//            }
//        }
//    }
//    
//    private func settingRefresh(){
//        self.refreshControl?.addTarget(self, action: #selector(VisitStudentController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
//    }
//    
//    private func settingSwipe(){
//        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:)))
//        swipeRight.direction = UISwipeGestureRecognizerDirection.right
//        self.view.addGestureRecognizer(swipeRight)
//    }
//    
//    
//    @IBAction func cancel(_ sender: Any) {
//        self.present(animation.animated_transitions(viewIndefiner: "TableViewController", duration: 0.5, type: kCATransitionPush, subtype: kCATransitionFromTop, view: view), animated:false, completion:nil)
//    }
//
//    func handleRefresh(_ refreshControl: UIRefreshControl) {
//        print("kek")
//        getScheduleInform()
//        self.tableView.reloadData()
//        refreshControl.endRefreshing()
//    }
//    
//    func swiped(_ gesture: UIGestureRecognizer) {
//        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
//            switch swipeGesture.direction {
//            case UISwipeGestureRecognizerDirection.right:
//                self.present(animation.animated_transitions(viewIndefiner: "TableViewController", duration: 0.7, type: kCATransitionPush, subtype: kCATransitionFromLeft, view: view), animated:false, completion:nil)
//                
//            default:
//                break
//            }
//        }
//    }
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
//    
//    // MARK: - Table view data source
//
//
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var result = 0
//        for lessonsArr in getSchedule.items{
//            for lessons in lessonsArr{
//                if lessons.lessonsId == activitySectionId{
//                    result = lessons.visitors.count
//                }
//            }
//        }
//        return result
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomStudentCell
//        
//        for lessonsArr in getSchedule.items{
//            for lessons in lessonsArr{
//                if lessons.lessonsId == activitySectionId{
//                    cell.nameStudent.text = "\(lessons.visitors[indexPath.row].firstName) \(lessons.visitors[indexPath.row].lastName)"
//
//                }
//            }
//        }
//
//
//        return cell
//    }
//
//}
