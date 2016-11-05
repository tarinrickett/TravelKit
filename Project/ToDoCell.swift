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
    
    func updateLabels() {
        
        let font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        body.font = font
        
    }
    
}
