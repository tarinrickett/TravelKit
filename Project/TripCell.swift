//
//  TripCell.swift
//  Project
//
//  Created by Tarin Rickett on 12/13/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class TripCell: UITableViewCell {
    
    @IBOutlet weak var location: UILabel!
    
    func updateLabels() {
        
        let font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        location.font = font
        
    }
    
}
