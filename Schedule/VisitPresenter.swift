//
//  VisitPresenter.swift
//  Schedule
//
//  Created by Влад Бирюков on 15.05.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation

class VisitPresenter: BasePresenter, UITableViewDataSource, UITableViewDelegate{
    
    let emailUser = UserDefaults.standard.value(forKey: "email") as! String
    let activitySectionId = UserDefaults.standard.value(forKey: "activite_section") as! Int

    
    var baseView = [VisitViewModel]()
    var userArr = [UserSchedule]()
    var visitController: VisitStudentController?
    
    
    func load(){
        
        self.visitController?.tableView.delegate = self
        self.visitController?.tableView.dataSource = self
        
        getUser()
        getScheduleMapperInform()
        settingRefresh()
    }
    
    private func settingRefresh(){
        self.visitController?.tableView.refreshControl?.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControlEvents.valueChanged)
    }
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        getScheduleMapperInform()
        self.visitController?.tableView.reloadData()
        refreshControl.endRefreshing()
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
    
    private func getScheduleMapperInform(){
        
        for user in userArr{
            if user.email == emailUser && user.activite == true{
                
                let _ = ScheduleInteractor().exute(gropId: String(user.idGroup), subgroup: user.subgroup).subscribe(onNext: {arr in
                    self.baseView = VisitMapper().transformVisitObject(schedules: arr)
                }, onError: {error in
                }, onCompleted: {
                    DispatchQueue.main.async {
                        self.visitController?.tableView.reloadData()
                    }
                }, onDisposed: {
                }).addDisposableTo(self.disposeBag)
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return baseView.count

    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomStudentCell

        cell.nameStudent.text = "\(baseView[indexPath.row].firstName) \(baseView[indexPath.row].lastName)"
        
        
        return cell
    }
    
    func cancel(){
        let vc = self.visitController?.storyboard?.instantiateViewController(withIdentifier: "TableViewController")
        self.visitController?.present(vc!, animated: true, completion: nil)
    }
    
    

}
