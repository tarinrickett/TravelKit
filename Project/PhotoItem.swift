//
//  PhotoItem.swift
//  Project
//
//  Created by Tarin Rickett on 11/28/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class PhotoItem: NSObject, NSCoding {
    
    //keys
    static let captionKey = "caption"
    static let selectedImageIDKey = "selectedImageID"
    
    //vars
    var caption: String
    var selectedImage: UIImage
    var selectedImageID: String
    
    init(_ caption: String, _ selectedImage: UIImage) {
        self.caption = caption
        self.selectedImage = selectedImage
        self.selectedImageID = NSUUID().uuidString
    }
    
    //decodes
//    required init(coder aDecoder: NSCoder) {
//        caption = aDecoder.decodeObject(forKey: PhotoItem.captionKey) as! String
//        selectedImageID = aDecoder.decodeObject(forKey: PhotoItem.selectedImageIDKey) as! String
//    }
    
    //encodes
    func encode(with aCoder: NSCoder) {
        aCoder.encode(caption, forKey: PhotoItem.captionKey)
        aCoder.encode(selectedImageID, forKey: PhotoItem.selectedImageIDKey)
    }
    
}
