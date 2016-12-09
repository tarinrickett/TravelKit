//
//  PhotoItem.swift
//  Project
//
//  Created by Tarin Rickett on 11/28/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class PhotoItem: NSObject { //, NSCoding
    
    var caption: String
    var selectedImage: UIImage
    
    init(_ caption: String, _ selectedImage: UIImage) {
        self.caption = caption
        self.selectedImage = selectedImage
    }
    
}
