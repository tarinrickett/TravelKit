//
//  ToDoItem.swift
//  Project
//
//  Created by Tarin Rickett on 10/29/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class ToDoItem: NSObject, NSCoding {
    
    //keys
    static let bodyKey = "body"
    //vars
    var body: String
    
    init(_ body: String) {
        self.body = body
    }
    
    //decodes
    required init(coder aDecoder: NSCoder) {
        body = aDecoder.decodeObject(forKey: ToDoItem.bodyKey) as! String
    }
    
    //encodes
    func encode(with aCoder: NSCoder) {
        aCoder.encode(body, forKey: ToDoItem.bodyKey)
    }
    
}
