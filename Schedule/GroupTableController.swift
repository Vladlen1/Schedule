//
//  GroupTableController.swift
//  Schedule
//
//  Created by Влад Бирюков on 25.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit
import RealmSwift

class GroupTableController: UITableViewController {

    private var emailUser = UserDefaults.standard.value(forKey: "email") as! String
    private let animation = Animation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)

    }
    
    
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
       self.present(animation.animated_transitions(viewIndefiner: "TableViewController", duration: 0.5, type: kCATransitionPush, subtype: kCATransitionFromTop, view: view), animated:false, completion:nil)
    }
    
    func swiped(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                self.present(animation.animated_transitions(viewIndefiner: "TableViewController", duration: 0.7, type: kCATransitionPush, subtype: kCATransitionFromTop, view: view), animated:false, completion:nil)
                
            default:
                break
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let realm = try! Realm()
        let group = realm.objects(ScheduleGroup.self).filter("email == %@", emailUser)
        
        return group.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GroupTableViewCell

        let realm = try! Realm()
        let group = realm.objects(ScheduleGroup.self).filter("email == %@", emailUser)
        cell.group.text = "\(group[indexPath.row].groupNumber) / \(group[indexPath.row].subGroup)"

        

        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let realm = try! Realm()

        let schedules = try! Realm().objects(ScheduleGroup.self)
        for schedule in schedules{
            if schedule.acrivite == true && schedule.email == emailUser{
                try! realm.write {
                    schedule.acrivite = false
                }
            }
        }
        
        let group = realm.objects(ScheduleGroup.self).filter("email == %@", emailUser)
        try! realm.write {
            group[indexPath.row].acrivite = true
        }
        
        self.present(animation.animated_transitions(viewIndefiner: "TableViewController", duration: 0.5, type: kCATransitionPush, subtype: kCATransitionFromRight, view: view), animated:false, completion:nil)
        
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (actin, indexPath) -> Void in
            
            let realm = try! Realm()
            let group = realm.objects(ScheduleGroup.self).filter("email == %@", self.emailUser)
            try! realm.write {
                realm.delete(group[indexPath.row])
            }
            
            let groupActive = realm.objects(ScheduleGroup.self).filter("acrivite == true").filter("email == %@", self.emailUser)
            if groupActive.count == 0{
                let group = realm.objects(ScheduleGroup.self).filter("email == %@", self.emailUser).first
                try! realm.write {
                    group?.acrivite = true
                }
            }

            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            
        })
        return [deleteAction]
    }

}
