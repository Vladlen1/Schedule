//
//  ScheduleController.swift
//  Schedule
//
//  Created by Влад Бирюков on 14.04.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit

class ScheduleController: UIViewController{

    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    let section = ["pizza", "deep dish pizza", "calzone"]
    
    let items = [["Margarita", "BBQ Chicken", "Pepperoni"], ["sausage", "meat lovers", "veggie lovers"], ["sausage", "chicken pesto", "prawns", "mushrooms"]]
    
    var searchActive : Bool = false

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self

        
        if self.revealViewController() != nil {
            revealViewController().rearViewRevealWidth = 210
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ScheduleController.longPress(_:)))
        longPressGesture.minimumPressDuration = 1.0 // 1 second press
        longPressGesture.delegate = self
        self.tableView.addGestureRecognizer(longPressGesture)
        
    }

     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
//        view.tintColor = UIColor.purple
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.red
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return section.count
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        cell.nameSubject.text = self.items[indexPath.section][indexPath.row]
        
//        cell.nameTeacher.text = self.prime[indexPath.section][2]
//        cell.time.text = self.prime[indexPath.section][5]
//        cell.room.text = self.prime[indexPath.section][0]
//        cell.numberOfPeople.text = self.prime[indexPath.section][1]
//        cell.typePair.text = self.prime[indexPath.section][3]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("dfdsf")
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "VisitStudentController") as! VisitStudentController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    func longPress(_ sender: AnyObject) {
        searchBar.resignFirstResponder()

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
            self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.middle)
        }
        let cancelAction = UIAlertAction(title: "Нет", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
            self.tableView.deselectRow(at: indexPath as IndexPath, animated: true)

        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func tapSearchBar(_ sender: Any) {
        searchBar.resignFirstResponder()

    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchActive = false;
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        
//        
//        let predicate = NSPredicate(format: "key_name BEGINSWITH [c]%@", searchText)
//        
//        var search_key = section[2]
//        
//        if(search_key.count == 0){
//            searchActive = false;
//        } else {
//            searchActive = true;
//        }
//        tableView.reloadData()
//        
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

//    // Override to support conditional editing of the table view.
//     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }


    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension ScheduleController:   UITableViewDataSource, UITableViewDelegate,  UITextFieldDelegate, UIGestureRecognizerDelegate, UISearchBarDelegate{

}
