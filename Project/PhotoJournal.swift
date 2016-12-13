//
//  PhotoJournal.swift
//  Project
//
//  Created by Tarin Rickett on 11/28/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class PhotoJournal: NSObject {
    
    var photos: [PhotoItem] = []
    
    // ================
    //  Manual Methods
    // ================
    
    //generate todo
    func generatePhoto (_ caption: String, _ selectedImage: UIImage) -> Int? {
        return addPhoto(PhotoItem(caption, selectedImage))
    }
    
    //manually add new todo from string
    func addPhoto (_ photo: PhotoItem) -> Int {
        photos.append(photo)
        return photos.index(of: photo)!
    }
    
    //remove todo
    func removePhoto (_ photo: PhotoItem) {
        if let index = photos.index(of: photo) {
            photos.remove(at: index)
        }
    }
    
    //move todo
    func movePhoto (_ fromIndex: Int, _ toIndex: Int) {
        if fromIndex != toIndex {
            let photo = photos[fromIndex]
            photos.remove(at: fromIndex)
            photos.insert(photo, at: toIndex)
        }
    }
    
}

