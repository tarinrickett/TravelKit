//
//  TravelViewController.swift
//  Project
//
//  Created by Tarin Rickett on 11/5/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class TravelViewController: UITableViewController, UIPickerViewDelegate {
    
//    var saveddata: SavedData!
    
    let TODOS = 0
    
    var ticketBook: TicketBook!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add + to navbar
        let plusButton = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.done, target: self, action: #selector(addToDo))
        navigationItem.rightBarButtonItem = plusButton
        print(navigationItem.rightBarButtonItem?.action)
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150

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
    
    /////////////////////////////////////
    // Image Picker Delegate Overrides //
    /////////////////////////////////////
    var imageTextField = UITextField()
    let imageOptions = [NSLocalizedString("Plane", comment: "Plane"),
                        NSLocalizedString("Train", comment: "Train"),
                        NSLocalizedString("Car", comment: "Car"),
                        NSLocalizedString("Walking", comment: "Walking"),
                        NSLocalizedString("None of the Above", comment: "None of the Above")]
    var imageSelection = -1
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return imageOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        imageSelection = row
        imageTextField.text = self.imageOptions[imageSelection]
    }
    
    //datepicker onchange function
    var dateTextField = UITextField()
    let dateFormatter = DateFormatter()
    @IBAction func datePickerChanged(sender: UIDatePicker) {
        dateFormatter.dateFormat = "MM/dd/yy @ HH:mm"
        dateTextField.text = dateFormatter.string(from: sender.date)
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
        
        let datePicker = UIDatePicker()
        datePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
        inputToDo.addTextField { (textField) in
            textField.inputView = datePicker;
            textField.text = "Select the Date and Time"
            self.dateTextField = textField
        }
        
        let imagePicker = UIPickerView()
        imagePicker.delegate = self
        inputToDo.addTextField { (textField) in
            textField.inputView = imagePicker;
            textField.text = "Select a Mode of Transport"
            self.imageTextField = textField
        }
        
        //on OK,
        inputToDo.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Itinerary Add OK"), style: .default, handler: { (_) in
            let bodyTextField = inputToDo.textFields![0]
            let dateTextField = inputToDo.textFields![1]
            //if user entered text,
            if bodyTextField.text != "" {
                let date = dateTextField.text!
                if let index = self.ticketBook.generateToDo(bodyTextField.text!, date, self.imageSelection) {
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
        return 1
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
            cell.updateIcon(todo.imageSelection)
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


