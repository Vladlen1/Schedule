//
//  GroupTablePresenter.swift
//  Schedule
//
//  Created by Влад Бирюков on 16.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

class GroupTablePresenter: BasePresenter, UITableViewDataSource, UITableViewDelegate {
    
    let emailUser = UserDefaults.standard.value(forKey: "email") as! String
    var listUser = [UserSchedule]()
    var listGroupUser = [UserSchedule]()
    
    var userArr = [UserSchedule]()
    var groupController : GroupTableController?
    let realm = try! Realm()

    
    func load() {
        self.groupController?.tableView.delegate = self
        self.groupController?.tableView.dataSource = self
        
        getGroupUser()
    }
    
    private func getUser() {
        let _ = UserInteractor().exute().subscribe(onNext: {obj in
            self.listUser.append(obj)
        }, onError: {error in
        }, onCompleted: {
            print("Complete")
        }, onDisposed: {
            
        }).addDisposableTo(self.disposeBag)
    
    }
    
    private func getGroupUser() {
        getUser()
        for user in listUser{
            if user.email == emailUser{
                self.listGroupUser.append(user)
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listGroupUser.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GroupTableViewCell
        
        cell.group.text = "\(listGroupUser[indexPath.row].groupNumber) / \(listGroupUser[indexPath.row].subgroup)"
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let schedules = try! Realm().objects(ScheduleGroup.self)
        for schedule in schedules {
            if schedule.acrivite == true && schedule.email == emailUser {
                try! realm.write {
                    schedule.acrivite = false
                }
            }
        }
        
        let group = realm.objects(ScheduleGroup.self).filter("email == %@", emailUser)
        try! realm.write {
            group[indexPath.row].acrivite = true
        }
        
        let vc = self.groupController?.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController")
        self.groupController?.present(vc!, animated: true, completion: nil)
        
            tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        }
        
        
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (actin, indexPath) -> Void in
        
        let group = self.realm.objects(ScheduleGroup.self).filter("email == %@", self.emailUser)
        try! self.realm.write {
            self.realm.delete(group[indexPath.row])
            self.listGroupUser.remove(at: indexPath.row)
        }
        
        let groupActive = self.realm.objects(ScheduleGroup.self).filter("acrivite == true").filter("email == %@", self.emailUser)
        if groupActive.count == 0 {
            let group = self.realm.objects(ScheduleGroup.self).filter("email == %@", self.emailUser).first
            try! self.realm.write {
                group?.acrivite = true
            }
        }
        
        self.groupController?.tableView.deleteRows(at: [indexPath], with: .fade)
        self.groupController?.tableView.reloadData()
        })
            return [deleteAction]
    }

    func cancel() {
        let vc = self.groupController?.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController")
        self.groupController?.present(vc!, animated: true, completion: nil)
    }
}
