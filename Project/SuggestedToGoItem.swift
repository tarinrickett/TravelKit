//
//  SuggestedToGoItem.swift
//  Project
//
//  Created by Tarin Rickett on 11/5/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class SuggestedToGoItem: NSObject, NSCoding {
    
    //keys
    static let bodyKey = "body"
    static let detailKey = "detail"
    
    //vars
    var body: String
    var detail: String
    
    init(_ body: String, _ detail: String) {
        self.body = body
        self.detail = detail
    }
    
    //decodes
    required init(coder aDecoder: NSCoder) {
        body = aDecoder.decodeObject(forKey: SuggestedToGoItem.bodyKey) as! String
        detail = aDecoder.decodeObject(forKey: SuggestedToGoItem.detailKey) as! String
    }
    
    //encodes
    func encode(with aCoder: NSCoder) {
        aCoder.encode(body, forKey: SuggestedToGoItem.bodyKey)
        aCoder.encode(detail, forKey: SuggestedToGoItem.detailKey)
    }
    
}
