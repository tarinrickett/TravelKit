////
////  SaveData.swift
////  Project
////
////  Created by Tarin Rickett on 11/26/16.
////  Copyright © 2016 Mobile Application Development. All rights reserved.
////
//
//import UIKit
//
//class SaveData: NSObject {
//    
//    //the archive URL
//    static let archiveURL: NSURL = {
//        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let documentDirectory = documentsDirectories.first!
//        return documentDirectory.appendingPathComponent("savedData.archive") as NSURL
//    }()
//    
//    //get saved data
//    class func getSavedData() -> SavedData {
//        if let saveddata = NSKeyedUnarchiver.unarchiveObject(withFile: archiveURL.path!) as? SavedData {
//            print("YAY")
//            return saveddata
//        }
//        else {
//            return SavedData()
//        }
//    }
//    
//    //set saved data
//    class func setSavedData(_ saveddata: SavedData) -> Bool {
//        return NSKeyedArchiver.archiveRootObject(saveddata, toFile: archiveURL.path!)
//    }
//    
//}
