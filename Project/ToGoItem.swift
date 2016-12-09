//
//  ToGoItem.swift
//  Project
//
//  Created by Tarin Rickett on 11/5/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class ToGoItem: NSObject, NSCoding {
    
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
        body = aDecoder.decodeObject(forKey: ToGoItem.bodyKey) as! String
        detail = aDecoder.decodeObject(forKey: ToGoItem.detailKey) as! String
    }
    
    //encodes
    func encode(with aCoder: NSCoder) {
        aCoder.encode(body, forKey: ToGoItem.bodyKey)
        aCoder.encode(detail, forKey: ToGoItem.detailKey)
    }
    
}
