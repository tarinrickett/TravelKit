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
    var checked = false
    
    func updateLabels() {
        let bodyFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        body.font = bodyFont
        let captionFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1)
        detail.font = captionFont
        
        if (checked) {
            contentView.backgroundColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) //maintain white bkg
            body.textColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.5) //font color = grey
            //style = strikethrough
            //            let attr = NSStrikethroughStyleAttributeName(NSNumber(numberWithInt: NSUnderlineStyleSingle))
            //            let attributedString = NSAttributedString(string: body.text!, attributes: [attr])
            //            body.attributedText = attributedString;
        } else {
            contentView.backgroundColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) //maintain white bkg
            body.textColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 1.0) //font color = black
            //style = plain
            //            accessoryType = UITableViewCellAccessoryNone;
        }
        
    }
    
}
