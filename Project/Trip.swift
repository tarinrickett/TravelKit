//
//  Trip.swift
//  Project
//
//  Created by Tarin Rickett on 12/13/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class TripItem: NSObject { //, NSCoding
    
    var location: String?
    var main: String?
    var temp: Int?
    
    init(_ location: String, _ main: String, _ temp: Int) {
        self.location = location
        self.main = main
        self.temp = temp
    }
    
}
