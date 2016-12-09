//
//  ImagePicker.swift
//  Project
//
//  Created by Tarin Rickett on 11/28/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class ImagePicker: UIPickerView, UIPickerViewDelegate {
    let imageOptions = ["Plane", "Train", "Car", "Walking", "None of the Above"]
    var imageSelection = -1
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageOptions.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return imageOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch (row) {
        case 0:
            imageSelection = 0
        case 1:
            imageSelection = 1
        case 2:
            imageSelection = 2
        case 3:
            imageSelection = 3
        case 4:
            imageSelection = 4
        default:
            imageSelection = 4
        }
    }
}
