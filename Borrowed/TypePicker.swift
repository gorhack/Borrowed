//
//  TypePicker.swift
//  Borrowed
//
//  Created by Kyle Gorak on 1/7/15.
//  Copyright (c) 2015 Kyle Gorak. All rights reserved.
//

import UIKit

class TypePicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var typeList: [String] = ["Test 1", "Test 2", "Test 3"]
    
    
    // Data Source methods:
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeList.count
    }
    
    // Delegate methods:
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return typeList[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // set selected item to typeList[row]
    }
}
