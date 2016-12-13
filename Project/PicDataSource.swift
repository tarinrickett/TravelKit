//
//  PicDataSource.swift
//  Project
//
//  Created by Tarin Rickett on 12/12/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit
import CoreData

class PicDataSource: NSObject, UICollectionViewDataSource {
    
    var pix: [Pic]
    
    override init() {
        //add saved data shit
        pix = [Pic]()
        super.init()
    }
    
    func getPic(uid: String) -> Pic? {
        if let pic = findPic(with: uid) {
            return pic
        } else {
//            return newPic(with: uid)
            return Pic("default", "default")
        }
    }
    
    func findPic(with uid: String) -> Pic? {
        for pic in pix {
            if pic.imageID == uid {
                return pic
            }
        }
        return nil
    }
    
//    func newPic(with uid: String) -> Pic? {
//        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
//            return nil
//        }
//        
//        let managedContext = delegate.persistentContainer.viewContext
//        
//        let entity = NSEntityDescription.entity(forEntityName: "Pic", in: managedContext)!
//        
//        let pic = Pic(entity, managedContext)
//        pic.imageID = uid
//        
//        pix.append(pic)
//        return pic
//    }
//    
//    func deletePic(pic: Pic) {
//        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
//            print("Failed to delete :(")
//            return
//        }
//        
//        if let index = pix.index(of: pic) {
//            let managedContext = delegate.persistentContainer.viewContext
//            managedContext.delete(pic)
//            pix.remove(at: index)
//        }
//    }
    
    //saved data shit method
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pix.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "UICollectionViewCell"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PicCell
        
        let pic = pix[indexPath.row]
        cell.imageView.image = ImageHelper.getImage(forUID: pic.imageID)!
        
        return cell
    }
    
}
