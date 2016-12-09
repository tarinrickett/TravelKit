//
//  TicketCell.swift
//  Project
//
//  Created by Tarin Rickett on 11/5/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class TicketCell: UITableViewCell {

    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var ticketIcon: UIImageView!
    
    func updateLabels() {
        let bodyFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        body.font = bodyFont
        let captionFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1)
        detail.font = captionFont
     }
    
    func updateIcon(_ imageSelection: Int) {
        switch(imageSelection) {
            case 0:
                ticketIcon.image = UIImage(named: "plane.png")
            case 1:
                ticketIcon.image = UIImage(named: "train.png")
            case 2:
                ticketIcon.image = UIImage(named: "car.png")
            case 3:
                ticketIcon.image = UIImage(named: "walk.png")
            case 4:
                ticketIcon.image = UIImage(named: "pin.png")
            default:
                ticketIcon.image = UIImage(named: "pin.png")
        }
    }
    
}
