//
//  LaunchScreenViewController.swift
//  Project
//
//  Created by Tarin Rickett on 11/5/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var iconXL: NSLayoutConstraint!
    @IBOutlet weak var iconXR: NSLayoutConstraint!
    
//    var saveddata: SavedData!
    
    //alpha and color animation
    func iconFadeIn() {
        UIView.animate(
            withDuration: 2,
            delay: 0,
            options: [],
            animations: { () -> Void in
                self.icon.alpha = 1
                self.view.backgroundColor = UIColor(colorLiteralRed: (21/255.0),
                                                    green: (189/255.0),
                                                    blue: (177/255.0),
                                                    alpha: 1.0)
            },
            completion: { (Bool) -> Void in
                self.iconToRight()
            }
        )
    }
    
    //constraint animation to right
    func iconToRight() {
        
        let width = view.frame.width
        
        iconXL.constant += width*2
        iconXR.constant += width*2
        
        UIView.animate(
            withDuration: 3,
            delay: 0,
            options: [.curveLinear],
            animations: { () -> Void in
                self.view.layoutIfNeeded()
            },
            completion: { (Bool) -> Void in
                self.iconToLeft()
            }
        )
    }
    
    //set constraint animation to start from left
    func iconToLeft() {
        
        let width = view.frame.width
        
        iconXL.constant = (0 - width)
        iconXR.constant = (0 - width)
        
        UIView.animate(
            withDuration: 0,
            delay: 0,
            options: [.curveLinear],
            animations: { () -> Void in
                self.view.layoutIfNeeded()
            },
            completion: { (Bool) -> Void in
                self.iconToRight()
            }
        )
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let myApp = UIApplication.shared
//        let myDelegate = myApp.delegate as! AppDelegate
//        saveddata = myDelegate.saveddata
        iconFadeIn()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
