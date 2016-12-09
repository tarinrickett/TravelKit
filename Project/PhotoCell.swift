//
//  PhotoCell.swift
//  Project
//
//  Created by Tarin Rickett on 11/28/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var journalImage: UIImageView!

    func updateLabels() {
        let captionFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1)
        caption.font = captionFont
    }
    
}
