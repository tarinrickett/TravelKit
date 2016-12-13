//
//  ToDoCell.swift
//  Project
//
//  Created by Tarin Rickett on 10/29/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class ToDoCell: UITableViewCell {
        
    @IBOutlet weak var body: UILabel!
//    var checked = false
    
    func updateLabels() {
        
        let font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        body.font = font
//        if (checked) {
//            body.textColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.5) //color = grey
//            //style = strikethrough
//        }
        
    }
    
}
