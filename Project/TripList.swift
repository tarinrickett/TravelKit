//
//  TripList.swift
//  Project
//
//  Created by Tarin Rickett on 12/13/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class TripList: NSObject {
    
    var trips: [TripItem] = []
    
    // ================
    //  Manual Methods
    // ================
    
    //generate trip
    func generateTrip (_ location: String) -> Int? {
        return addTrip(TripItem(location))
    }
    func generateTrip (_ location: String, _ weather: String, _ temp: Int) -> Int? {
        return addTrip(TripItem(location, weather, temp))
    }
    
    //manually add new todo from string
    func addTrip (_ trip: TripItem) -> Int {
        print("just appended trip")
        trips.append(trip)
        return trips.index(of: trip)!
    }
    
    //remove todo
    func removeTrip (_ trip: TripItem) {
        if let index = trips.index(of: trip) {
            trips.remove(at: index)
        }
    }
    
    //move todo
    func moveTrip (_ fromIndex: Int, _ toIndex: Int) {
        if fromIndex != toIndex {
            let trip = trips[fromIndex]
            trips.remove(at: fromIndex)
            trips.insert(trip, at: toIndex)
        }
    }
    
}
