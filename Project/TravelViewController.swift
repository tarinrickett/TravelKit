//
//  TravelViewController.swift
//  Project
//
//  Created by Tarin Rickett on 11/5/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class TravelViewController: UITableViewController {
    
    let SUGGESTED_TODOS = 0
    let TODOS = 1
    
    var packingList: PackingList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 75
        
        packingList = PackingList()
        if let indexArray = packingList.generateSuggested() {
            for index in indexArray {
                let indexPath = NSIndexPath(row: index, section: TODOS)
                tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // toggle edit mode
    @IBAction func toggleEditMode(_ sender: UIButton) {
        if isEditing == false {
            setEditing(true, animated: true)
            sender.setTitle("Done", for: .normal)
        } else {
            setEditing(false, animated: true)
            sender.setTitle("Edit", for: .normal)
        }
    }
    
    // manually add new to do
    @IBAction func addToDo (_ sender: AnyObject) {
        if let index = packingList.generateToDo("Example To Do") {
            let indexPath = NSIndexPath(row: index, section: TODOS)
            tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
        }
    }
    
    // get number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // do i need this? I don't want section headers I just want indecernable sections
    func getSectionHeader (_ sectionNumber: Int) -> String? {
        switch sectionNumber {
        case SUGGESTED_TODOS:
            return "Suggested"
        case TODOS:
            return "To Dos"
        default:
            return nil
        }
    }
    
    func getNumberOfRowsInSection(_ sectionNumber: Int) -> Int {
        switch(sectionNumber) {
        case SUGGESTED_TODOS:
            return packingList.suggestedToDos.count
        case TODOS:
            return packingList.todos.count
        default:
            return 0
        }
    }
    
    func getTableCell(_ path: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: path) as! ToDoCell
        cell.updateLabels()
        
        switch(path.section) {
        case SUGGESTED_TODOS:
            let todo = packingList.suggestedToDos[path.row]
            cell.body?.text = todo.body
        case TODOS:
            let todo = packingList.todos[path.row]
            cell.body?.text = todo.body
        default:
            cell.body?.text = "Unknown"
        }
        
        return cell
        
    }
    
    func deleteRow(_ path: IndexPath) {
        switch(path.section) {
        case SUGGESTED_TODOS:
            let todo = packingList.suggestedToDos[path.row]
            verifyDelete(todo.body, {
                (action) -> Void in
                self.packingList.removeSuggestedToDo(todo)
                self.tableView.deleteRows(at: [path], with: .automatic)
            })
        case TODOS:
            let todo = packingList.todos[path.row]
            verifyDelete(todo.body, {
                (action) -> Void in
                self.packingList.removeToDo(todo)
                self.tableView.deleteRows(at: [path], with: .automatic)
            })
        default:
            break
        }
    }
    
    //
    // helper function that deletes an item from the collection
    //
    
    func verifyDelete(_ name: String, _ delete: @escaping (UIAlertAction) -> Void) {
        let title = "Delete \(name)?"
        let message = "Are you sure that you want to delete this item?"
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: delete)
        ac.addAction(deleteAction)
        
        present(ac, animated: true, completion: nil)
    }
    
    func moveRow(_ from: IndexPath, _ to: IndexPath) {
        switch(from.section) {
        case SUGGESTED_TODOS:
            packingList.moveSuggestedToDo(from.row, to.row)
        case TODOS:
            packingList.moveToDo(from.row, to.row)
        default:
            break
        }
    }
    
    //
    // delgate functions; mostly call helper functions (above)
    //
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // call the helper function
        return getSectionHeader(section)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // call the helper function
        return getNumberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // call the helper function
        return getTableCell(indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // call the helper function
            deleteRow(indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        moveRow(sourceIndexPath, destinationIndexPath)
    }
    
}


