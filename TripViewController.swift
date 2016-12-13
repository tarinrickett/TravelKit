//
//  TripViewController.swift
//  Project
//
//  Created by Tarin Rickett on 12/13/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class TripViewController: UITableViewController, UITextFieldDelegate {
    
    var saveddata: SavedData!
    
    let TRIPS = 1
    
    var tripList: TripList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 75
        
        let myApp = UIApplication.shared
        let myDelegate = myApp.delegate as! AppDelegate
        saveddata = myDelegate.saveddata
        
        tripList = TripList()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // toggle edit mode
    @IBAction func toggleEditMode(_ sender: AnyObject) {
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
    @IBAction func addTrip (_ sender: AnyObject) {
        //create a pop-up alert
        let inputTrip = UIAlertController(title: "Add a new trip",
                                          message: "Enter a location",
                                          preferredStyle: .alert)
        //programmatically add text field for inputting a location (name)
        inputTrip.addTextField { (textField) in
            textField.text = "" //no default text
        }
        
        //programmatically add stack view for photo tool bar
        let photoStackView = UIStackView();
        //photoStackView.axis = UILayoutConstraintAxisVertical;
        //photoStackView.distribution = UIStackViewDistributionEqualSpacing;
        //photoStackView.alignment = UIStackViewAlignmentCenter;
        photoStackView.spacing = 30;
        
        //let takePhotoButton = UIButton();
        //let choosePhotoButton = UIButton();
        
        //[photoStackView addArrangedSubview: view1];
        photoStackView.translatesAutoresizingMaskIntoConstraints = false;
        //[self.view addSubview: photoStackView];
        
        //on OK,
        inputTrip.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "To-Do Add OK"),
                                          style: .default, handler: { (_) in
                                            let textField = inputTrip.textFields![0]
                                            //if user entered text,
                                            if textField.text != "" {
                                                //add to table
                                                if let index = self.tripList.generateTrip(textField.text!) {
                                                    let indexPath = NSIndexPath(row: index, section: self.TRIPS)
                                                    self.tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
                                                }
                                            }
        }))
        //do the pop-up alert
        self.present(inputTrip, animated: true, completion: nil)
    }
    
    // get number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // do i need this? I don't want section headers I just want indecernable sections
    func getSectionHeader (_ sectionNumber: Int) -> String? {
        switch sectionNumber {
        case TRIPS:
            return "My Trips"
        default:
            return nil
        }
    }
    
    func getNumberOfRowsInSection(_ sectionNumber: Int) -> Int {
        switch(sectionNumber) {
        case TRIPS:
            return tripList.trips.count
        default:
            return 0
        }
    }
    
    func getTableCell(_ path: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell", for: path) as! TripCell
        cell.updateLabels()
        
        switch(path.section) {
        case TRIPS:
            let trip = tripList.trips[path.row]
            cell.location?.text = trip.location
        default:
            cell.location?.text = NSLocalizedString("Unknown", comment: "To-Do Unknown")
        }
        
        return cell
        
    }
    
    func deleteRow(_ path: IndexPath) {
        switch(path.section) {
        case TRIPS:
            let trip = tripList.trips[path.row]
            verifyDelete(trip.location, {
                (action) -> Void in
                self.tripList.removeTrip(trip)
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
        case TRIPS:
            tripList.moveTrip(from.row, to.row)
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

