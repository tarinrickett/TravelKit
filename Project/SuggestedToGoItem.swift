//
//  SuggestedToGoItem.swift
//  Project
//
//  Created by Tarin Rickett on 11/5/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class SuggestedToGoItem: NSObject {
    
    var body: String
    var detail: String
    
    init(_ body: String, _ detail: String) {
        self.body = body
        self.detail = detail
    }
    
}
