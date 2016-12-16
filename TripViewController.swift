//
//  TripViewController.swift
//  Project
//
//  Created by Tarin Rickett on 12/13/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class TripViewController: UITableViewController, UITextFieldDelegate, UIPickerViewDelegate {
    
//    var saveddata: SavedData!
    
    let TRIPS = 1
    var tripList: TripList!

    @IBOutlet weak var welcomeView: UIView!
    @IBOutlet weak var welcomeY: NSLayoutConstraint!
    
    //dismiss welcome view
    func viewSlideUp() {
        //set varbs
//        let height = view.frame.height
//        self.welcomeY.constant += height
//        //animate
//        UIView.animate(
//            withDuration: 2,
//            delay: 2,
//            options: [.curveLinear],
//            animations: { () -> Void in
//                self.view.layoutIfNeeded()
//            }
//        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //customize nav bar appearance
        navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: (21/255.0),
                                                                   green: (189/255.0),
                                                                   blue: (177/255.0), alpha: 1.0)
        navigationController?.navigationBar.tintColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let plusButton = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.done, target: self, action: #selector(addTrip))
        navigationItem.setRightBarButton(plusButton, animated: false);
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 75
//        
//        let myApp = UIApplication.shared
//        let myDelegate = myApp.delegate as! AppDelegate
//        saveddata = myDelegate.saveddata
        
        tripList = TripList()
        viewSlideUp()
        
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
    
    //////////////////////
    // PICKER DELEGATES //
    //////////////////////
    var updateTextField = UITextField()
    var citySelection = -1
    let cities = Locations.cities
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        citySelection = row
        return cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateTextField.text = self.cities[citySelection]
    }
    
    // manually add new to do
    @IBAction func addTrip (_ sender: AnyObject) {
        //create a pop-up alert
        let inputTrip = UIAlertController(title: "Add a new trip",
                                          message: "Enter a location",
                                          preferredStyle: .alert)
        //programmatically add text field for inputting a location (name)
        let locationsPicker = UIPickerView()
        locationsPicker.delegate = self
        inputTrip.addTextField{ (textField) in
            textField.text = ""
            textField.inputView = locationsPicker;
            self.updateTextField = textField
        }
        
        //on OK,
        inputTrip.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "To-Do Add OK"),
                                          style: .default, handler: { (_) in
                                            let textField = inputTrip.textFields![0]
                                            //if user entered text,
                                            if textField.text != "" {
                                                //add to table
//                                                if let index = self.getWeather(Locations.getCode(textField.text!)) {
//                                                    print("the index is fucking: ")
//                                                    print(index)
//                                                    let indexPath = NSIndexPath(row: index, section: self.TRIPS)
//                                                    self.tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
//                                                }
                                                if let index = self.tripList.generateTrip(textField.text!) {
                                                    let indexPath = NSIndexPath(row: index, section: self.TRIPS)
                                                    self.tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
                                                    self.tripList.trips[index] = self.getWeather(Locations.getCode(textField.text!))
                                                    print(self.tripList.trips[index])
                                                    print(self.tripList.trips[index].location)
                                                    print(self.tripList.trips[index].main)
                                                    print(self.tripList.trips[index].temp)
                                                }
                                            }
        }))
        //do the pop-up alert
        self.present(inputTrip, animated: true, completion: nil)
    }
    
    ///////////////////
    // JSON Fetching //
    ///////////////////
    var fetcher = WeatherFetcher()
    var returnIndex = TripItem("")
    func getWeather(_ location: String) -> TripItem {
        //get weather
        fetcher.fetchWeather(for: location) { (weatherResult) -> Void in
            switch(weatherResult) {
            case let .WeatherSuccess(weather):
                OperationQueue.main.addOperation() {
                    self.returnIndex = self.updateWeather(with: weather)
                    print("self.updateWeather is:")
                    print(self.returnIndex)
                }
            case let .WeatherFailure(error):
                print("error: \(error)")
            }
            print("reached the end of fetcher.fetchWeather...")
        }
        print("finally exited fetcher.fetchWeather")
        if (returnIndex.location == "") {
            returnIndex.location = Locations.getCity(location)
        }
        return returnIndex
    }
    private func updateWeather(with weather: TripItem) -> TripItem {
        print(weather.location)
        print(weather.main)
        print(weather.temp)
        return TripItem(weather.location!, weather.main!, weather.temp!)
    }
    
    // get number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // i don't want section headers
    func getSectionHeader (_ sectionNumber: Int) -> String? {
        return nil
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
            verifyDelete(trip.location!, {
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //on select row,
        //programmatically transition to that view
    }

    
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

