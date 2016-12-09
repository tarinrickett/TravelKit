//
//  TicketItem.swift
//  Project
//
//  Created by Tarin Rickett on 11/28/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class TicketItem: NSObject { //, NSCoding
    
    var body: String
    var detail: String
    var imageSelection: Int
    
    init(_ body: String, _ detail: String, _ imageSelection: Int) {
        self.body = body
        self.detail = detail
        self.imageSelection = imageSelection
    }
    
}
