//
//  ItemType.swift
//  Borrowed
//
//  Created by Kyle Gorak on 1/7/15.
//  Copyright (c) 2015 Kyle Gorak. All rights reserved.
//

import UIKit

class ItemType: ListController, UIPickerViewDataSource, UIPickerViewDelegate {

    var types: [String] = ["Test 1", "Test 2", "Test 3"]
    
    var currentType: String?
    
    @IBOutlet var type: UIPickerView!

    required override init(coder: NSCoder) {
        super.init(frame: self)
        type.delegate = self
        type.dataSource = self
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return types[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentType = types[row]
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return CGFloat(frame.width)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return types.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
}
