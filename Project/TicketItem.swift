//
//  TicketItem.swift
//  Project
//
//  Created by Tarin Rickett on 11/28/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class TicketItem: NSObject, NSCoding {
    
    //keys
    static let bodyKey = "body"
    static let detailKey = "detail"
    static let imageSelectionKey = "imageSelection"
    
    //vars
    var body: String
    var detail: String
    var imageSelection: Int
    
    init(_ body: String, _ detail: String, _ imageSelection: Int) {
        self.body = body
        self.detail = detail
        self.imageSelection = imageSelection
    }
    
    //decodes
    required init(coder aDecoder: NSCoder) {
        body = aDecoder.decodeObject(forKey: TicketItem.bodyKey) as! String
        detail = aDecoder.decodeObject(forKey: TicketItem.detailKey) as! String
        imageSelection = aDecoder.decodeObject(forKey: TicketItem.imageSelectionKey) as! Int
    }
    
    //encodes
    func encode(with aCoder: NSCoder) {
        aCoder.encode(body, forKey: TicketItem.bodyKey)
        aCoder.encode(detail, forKey: TicketItem.detailKey)
        aCoder.encode(imageSelection, forKey: TicketItem.imageSelectionKey)
    }
    
}
