//
//  Trip.swift
//  Project
//
//  Created by Tarin Rickett on 12/13/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class TripItem: NSObject { //, NSCoding
    
    var location: String
    var weather: String
    var temp: Int?
    
    init(_ location: String, _ weather: String, _ temp: Int) {
        self.location = location
        self.weather = weather
        self.temp = temp
    }
    
}
