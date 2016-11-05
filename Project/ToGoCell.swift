//
//  ToGoCell.swift
//  Project
//
//  Created by Tarin Rickett on 11/5/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class ToGoCell: UITableViewCell {
    
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var detail: UILabel!
    
    func updateLabels() {
        let bodyFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        body.font = bodyFont
        let captionFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1)
        detail.font = captionFont
    }
    
}
