//
//  ImageHelper.swift
//  Project
//
//  Created by Tarin Rickett on 11/26/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class ImageHelper: NSObject {
    
    class func saveImage(_ image: UIImage, forUID uid: String) {
        let imageURL = ImageHelper.imageURLForUID(uid)
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            do {
                try data.write(to: imageURL, options: .atomic)
            }
            catch {
                print("could not save \(uid)")
            }
        }
    }
    
    class func getImage(forUID uid: String) -> UIImage? {
        let imageURL = ImageHelper.imageURLForUID(uid)
        guard let imageFromDisk = UIImage(contentsOfFile: imageURL.path) else {
            return nil
        }
        
        return imageFromDisk
    }
    
    class func imageURLForUID(_ key: String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent(key)
    }
    
}

