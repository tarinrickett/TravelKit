//
//  PicItem.swift
//  Project
//
//  Created by Tarin Rickett on 12/12/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class Pic: NSObject {
    
    var caption: String
    var imageID: String
    
    init(_ caption: String, _ imageID: String) {
        self.caption = caption
        self.imageID = imageID
    }
    
}
