//
//  Suggestions.swift
//  Project
//
//  Created by Tarin Rickett on 12/16/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class Suggestions: NSObject {
    
    //populate different weather suggestions
    static let snowSuggestions = [
        SuggestedToDoItem("Snow Boots")]
    
    static let rainSuggestions = [
        SuggestedToDoItem("Rain coat"),
        SuggestedToDoItem("Umbrella"),
        SuggestedToDoItem("Galoshes")]
    
    static let extremeSuggestions = [
        SuggestedToDoItem("Hard hat")]
    
    static let sunnySuggestions = [
        SuggestedToDoItem("Sunglasses"),
        SuggestedToDoItem("Sunscreen")]
    
    static let coldSuggestions = [
        SuggestedToDoItem("Winter Parka"),
        SuggestedToDoItem("Scarf"),
        SuggestedToDoItem("Mittens")]
    
    static let hotSuggestions = [
        SuggestedToDoItem("Tank top"),
        SuggestedToDoItem("Shorts"),
        SuggestedToDoItem("Portable fan")]
    
    static let defaultSuggestions = [
        SuggestedToDoItem(NSLocalizedString("Good walking shoes", comment: "To-Do Suggestion 1")),
        SuggestedToDoItem(NSLocalizedString("Toothbrush", comment: "To-Do Suggestion 2")),
        SuggestedToDoItem(NSLocalizedString("ID / Passport", comment: "To-Do Suggestion 3"))]
    
    
    //get suggested items for a location's weather report
    static func getSuggestions(_ weather: TripItem) -> [SuggestedToDoItem]{
        var returnItems: [SuggestedToDoItem] = []
        
        //add temp specific items
        if (weather.temp! <= 273) {
            for item in coldSuggestions {
                returnItems.append(item)
            }
        } else if (weather.temp! > 300) {
            for item in hotSuggestions {
                returnItems.append(item)
            }
        }
        
        //add weather condition specific items
        if (weather.main == "Snow") {
            for item in snowSuggestions {
                returnItems.append(item)
            }
        } else if (weather.main == "Rain") {
            for item in rainSuggestions {
                returnItems.append(item)
            }
        } else if (weather.main == "Extreme") {
            for item in extremeSuggestions {
                returnItems.append(item)
            }
        } else if (weather.main == "Sunny") {
            for item in sunnySuggestions {
                returnItems.append(item)
            }
        }
        
        //add default items
        for item in defaultSuggestions {
            returnItems.append(item)
        }
        
        return returnItems

    }
    
}
