//
//  TravelViewController.swift
//  Project
//
//  Created by Tarin Rickett on 11/5/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class TravelViewController: UITableViewController {
    
    let TODOS = 0
    
    var ticketBook: TicketBook!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        ticketBook = TicketBook()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // toggle edit mode
    @IBAction func toggleEditMode(_ sender: UIButton) {
        if isEditing == false {
            setEditing(true, animated: true)
            sender.setTitle(NSLocalizedString("Done", comment: "Ticket Done"), for: .normal)
        } else {
            setEditing(false, animated: true)
            sender.setTitle(NSLocalizedString("Edit", comment: "Ticket Edit"), for: .normal)
        }
    }
    
    // manually add new to do
    @IBAction func addToDo (_ sender: AnyObject) {
        //create a pop-up alert
        let inputToDo = UIAlertController(title: NSLocalizedString("Add Ticket", comment: "Ticket Add Title"),
                                          message: NSLocalizedString("Enter your travel ticket and some details", comment: "Ticket Add Description"),
                                          preferredStyle: .alert)
        //programmatically add text fields for inputting a to-do item
        inputToDo.addTextField { (textField) in
            textField.text = "" //no default text
        }
        inputToDo.addTextField { (textField) in
            textField.text = "" //no default text
        }
        //on OK,
        inputToDo.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Itinerary Add OK"), style: .default, handler: { (_) in
            let bodyTextField = inputToDo.textFields![0]
            let detailTextField = inputToDo.textFields![1]
            //if user entered text,
            if bodyTextField.text != "" {
                //add to table
                if let index = self.ticketBook.generateToDo(bodyTextField.text!, detailTextField.text!) {
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
        case TODOS:
            return NSLocalizedString("Tickets", comment: "Tickets Section Title")
        default:
            return nil
        }
    }
    
    func getNumberOfRowsInSection(_ sectionNumber: Int) -> Int {
        switch(sectionNumber) {
        case TODOS:
            return ticketBook.todos.count
        default:
            return 0
        }
    }
    
    func getTableCell(_ path: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketCell", for: path) as! TicketCell
        cell.updateLabels()
        
        switch(path.section) {
        case TODOS:
            let todo = ticketBook.todos[path.row]
            cell.body?.text = todo.body
            cell.detail?.text = todo.detail
        default:
            cell.body?.text = NSLocalizedString("Unknown", comment: "Ticket Unknown")
            cell.detail?.text = NSLocalizedString("Unknown", comment: "Ticket Unknown")
        }
        
        return cell
        
    }
    
    func deleteRow(_ path: IndexPath) {
        switch(path.section) {
        case TODOS:
            let todo = ticketBook.todos[path.row]
            verifyDelete(todo.body, {
                (action) -> Void in
                self.ticketBook.removeToDo(todo)
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
        let title = NSLocalizedString("Delete \(name)?", comment: "Ticket Delete Title")
        let message = NSLocalizedString("Are you sure that you want to delete this item?", comment: "Ticket Delete Message")
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Ticket Delete Cancel Option"),
                                         style: .cancel, handler: nil)
        ac.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: NSLocalizedString("Delete", comment: "Ticket Delete Delete Confirmation"),
                                         style: .destructive, handler: delete)
        ac.addAction(deleteAction)
        
        present(ac, animated: true, completion: nil)
    }
    
    func moveRow(_ from: IndexPath, _ to: IndexPath) {
        switch(from.section) {
        case TODOS:
            ticketBook.moveToDo(from.row, to.row)
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


