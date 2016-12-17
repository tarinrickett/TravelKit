//
//  PhotoViewController.swift
//  Project
//
//  Created by Tarin Rickett on 11/26/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class PhotoViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
//    var saveddata: SavedData!
    var selectedImage = UIImage(named: "pin.png")
    
    ///////////////////
    // TABLE METHODS //
    ///////////////////
    
    let PHOTOS = 0
    var photoJournal: PhotoJournal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add + to navbar
        let plusButton = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.done, target: self, action: #selector(addPhoto))
        navigationItem.rightBarButtonItem = plusButton
        print(navigationItem.rightBarButtonItem?.action)
        
        //table setup
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 185

        photoJournal = PhotoJournal()
        
        //image setup
        if(!UIImagePickerController.isSourceTypeAvailable(.camera)) {
            cameraButton.isEnabled = false
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // toggle edit mode
    @IBAction func toggleEditMode(_ sender: UIBarButtonItem) {
        if isEditing == false {
            setEditing(true, animated: true)
            sender.title = NSLocalizedString("Done", comment: "To-Do Done")
        } else {
            setEditing(false, animated: true)
            sender.title = NSLocalizedString("Edit", comment: "To-Do Edit")
        }
    }
    
    // manually add new to do
    func addPhoto () {
        //create a pop-up alert
        let inputCaption = UIAlertController(title: NSLocalizedString("Add Caption", comment: "Add Caption"),
                                             message: NSLocalizedString("Inlude some details about your photo", comment: "Photo Details"),
                                          preferredStyle: .alert)
        //programmatically add text field for inputting a caption
        inputCaption.addTextField { (textField) in
            textField.text = "" //no default text
        }
        
        //on OK,
        inputCaption.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Itinerary Add OK"), style: .default, handler: { (_) in
            let captionTextField = inputCaption.textFields![0]
            //if user entered text,
            if captionTextField.text != "" {
                if let index = self.photoJournal.generatePhoto(captionTextField.text!, self.selectedImage!) {
                    let indexPath = NSIndexPath(row: index, section: self.PHOTOS)
                    self.tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
                }
            }
        }))
        //do the pop-up alert
        self.present(inputCaption, animated: true, completion: nil)
    }
    
    // get number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // do i need this? I don't want section headers I just want indecernable sections
    func getSectionHeader (_ sectionNumber: Int) -> String? {
        switch sectionNumber {
        case PHOTOS:
            return NSLocalizedString("My Photos", comment: "My Photos")
        default:
            return nil
        }
    }
    
    func getNumberOfRowsInSection(_ sectionNumber: Int) -> Int {
        switch(sectionNumber) {
        case PHOTOS:
            return photoJournal.photos.count
        default:
            return 0
        }
    }
    
    func getTableCell(_ path: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: path) as! PhotoCell
        cell.updateLabels()
        
        switch(path.section) {
        case PHOTOS:
            let photo = photoJournal.photos[path.row]
            cell.caption?.text = photo.caption
            cell.journalImage.image = self.selectedImage
        default:
            cell.caption?.text = NSLocalizedString("Unknown", comment: "Ticket Unknown")
            cell.journalImage.image = UIImage(named: "pin.png")
        }
        
        return cell
        
    }
    
    func deleteRow(_ path: IndexPath) {
        switch(path.section) {
        case PHOTOS:
            let photo = photoJournal.photos[path.row]
            verifyDelete(photo.caption, {
                (action) -> Void in
                self.photoJournal.removePhoto(photo)
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
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Ticket Delete Cancel Option"), style: .cancel, handler: nil)
        ac.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: NSLocalizedString("Delete", comment: "Ticket Delete Delete Confirmation"), style: .destructive, handler: delete)
        ac.addAction(deleteAction)
        
        present(ac, animated: true, completion: nil)
    }
    
    func moveRow(_ from: IndexPath, _ to: IndexPath) {
        switch(from.section) {
        case PHOTOS:
            photoJournal.movePhoto(from.row, to.row)
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
    
    
    ///////////////////
    // IMAGE METHODS //
    ///////////////////
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBAction func takePhoto(_ sender: AnyObject) {
        let picker = UIImagePickerController()
        
        //double check that if camera is available,
        //open camera
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func choosePhoto(_ sender: AnyObject) {
        let picker = UIImagePickerController()
        //photo library should always be available
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    //on image choice,
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let photo = info[UIImagePickerControllerOriginalImage] as! UIImage
        //set image to chosen photo
        self.selectedImage = photo
        dismiss(animated: true, completion: nil)
        addPhoto()
    }
    
    //blow up image on image tap
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //get image
        let blowUpImage: UIImage = photoJournal.photos[indexPath.row].selectedImage
        let blowUpImageView = UIImageView(image: blowUpImage)
        blowUpImageView.frame = self.view.frame
        blowUpImageView.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.75)
        blowUpImageView.contentMode = .scaleAspectFit
        //programmatically add tap gesture recognizer
        blowUpImageView.isUserInteractionEnabled = true
        let myTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissBlowUpImage))
        blowUpImageView.addGestureRecognizer(myTapGestureRecognizer)
        self.view.addSubview(blowUpImageView)
    }
    
    //dismiss on second tap
    func dismissBlowUpImage(sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
    
}

