//
//  Locations.swift
//  Project
//
//  Created by Tarin Rickett on 12/15/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class Locations: NSObject {

    static func getCode(_ location: String) -> String {
        return codes[cities.index(of: location)!]
    }
    
    static func getCity(_ location: String) -> String {
        return cities[codes.index(of: location)!]
    }
    
    static let cities = [
        "London",
        "New York",
        "Oxford",
        "Paris",
        "Sydney"
    ]
    
    static let codes = [
        "2643743",
        "5128638",
        "2640729",
        "6455259",
        "2147714"
    ]

}
