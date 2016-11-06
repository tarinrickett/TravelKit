//
//  ViewController.swift
//  Project
//
//  Created by Tarin Rickett on 10/25/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class PackingListViewController: UITableViewController, UITextFieldDelegate {
    
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
            sender.setTitle(NSLocalizedString("Done", comment: "To-Do Done"),
                            for: .normal)
        } else {
            setEditing(false, animated: true)
            sender.setTitle(NSLocalizedString("Edit", comment: "To-Do Edit"),
                            for: .normal)
        }
    }

    // manually add new to do
    @IBAction func addToDo (_ sender: AnyObject) {
        //create a pop-up alert
        let inputToDo = UIAlertController(title: NSLocalizedString("Add To-Do", comment: "To-Do Add Title"),
                                          message: NSLocalizedString("Enter something to pack", comment: "To-Do Add Description"),
                                          preferredStyle: .alert)
        //programmatically add text field for inputting a to-do item
        inputToDo.addTextField { (textField) in
            textField.text = "" //no default text
        }
        //on OK,
        inputToDo.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "To-Do Add OK"),
                                          style: .default, handler: { (_) in
            let textField = inputToDo.textFields![0]
            //if user entered text,
            if textField.text != "" {
                //add to table
                if let index = self.packingList.generateToDo(textField.text!) {
                    let indexPath = NSIndexPath(row: index, section: self.TODOS)
                    self.tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
                }
            }
        }))
        //do the pop-up alert
        self.present(inputToDo, animated: true, completion: nil)
    }
    
    // get number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // do i need this? I don't want section headers I just want indecernable sections
    func getSectionHeader (_ sectionNumber: Int) -> String? {
        switch sectionNumber {
        case SUGGESTED_TODOS:
            return NSLocalizedString("Suggested", comment: "To-Do Suggested Section Title")
        case TODOS:
            return NSLocalizedString("To Dos", comment: "To-Do To Dos Section Title")
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
            cell.body?.text = NSLocalizedString("Unknown", comment: "To-Do Unknown")
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
        let title = NSLocalizedString("Delete \(name)?", comment: "To-Do Delete Title")
        let message = NSLocalizedString("Are you sure that you want to delete this item?", comment: "To-Do Delete Message")
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "To-Do Delete Cancel Option"), style: .cancel, handler: nil)
        ac.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: NSLocalizedString("Delete", comment: "To-Do Delete Delete Confirmation"), style: .destructive, handler: delete)
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

