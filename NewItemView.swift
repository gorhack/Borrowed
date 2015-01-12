//
//  NewItemView.swift
//  Borrowed
//
//  Created by Kyle Gorak on 12/30/14.
//  Copyright (c) 2014 Kyle Gorak. All rights reserved.
//

import UIKit
import CoreData

class NewItemView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // Variables to load item data for editing
    
    var existingItem: NSManagedObject!
    var selectedItemName: String = ""
    var selectedBorrowerName: String = ""
    var selectedDescription: String = ""
    var selectedPicker: Int = -1
    var selectedDate: NSDate = NSDate()
    
    // values for picker TODO: New model with user entered values
    var typeList: [String] = ["Test 1", "Test 2", "Test 3"]
    
    // User fields
    
    @IBOutlet weak var itemNameText: UITextField!
    @IBOutlet weak var borrowerNameText: UITextField!
    @IBOutlet weak var descText: UITextField!
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext {
            return managedObjectContext
        }
        else {
            return nil
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Set up type picker
        
        typePicker.delegate = self
        typePicker.dataSource = self
        
        // Load existing item
        
        if (existingItem != nil) {
            // set title if editing an item
            
            self.navigationItem.title = "Edit Item"
            
            // set details to local instance
            
            itemNameText.text = selectedItemName
            borrowerNameText.text = selectedBorrowerName
            descText.text = selectedDescription
            typePicker.selectRow(selectedPicker as Int, inComponent: 0, animated: false)
            dueDatePicker.setDate(selectedDate, animated: false)
            
        } else {
            // set title if adding an item
            
            self.navigationItem.title = "New Item"
        }
    }
    
    @IBAction func save(sender: AnyObject) {
        // reference managed object context
        
        let context = managedObjectContext!
        let en = NSEntityDescription.entityForName("ItemRecord", inManagedObjectContext: context)
        
        // check if item already exists
        
        if (existingItem != nil) {
            // if the item already exists, save item with new values
            
            existingItem.setValue(itemNameText.text, forKey:"itemName")
            existingItem.setValue(borrowerNameText.text, forKey:"borrowerName")
            existingItem.setValue(descText.text, forKey:"desc")
            existingItem.setValue(selectedPicker as NSNumber, forKey:"itemTypeID")
            existingItem.setValue(dueDatePicker.date, forKey: "dueDate")
        } else {
            // create instance of data model
            
            var newItem = ItemRecord(entity: en!, insertIntoManagedObjectContext: context)
            
            // set data to new instance
            
            newItem.itemName = itemNameText.text
            newItem.borrowerName = borrowerNameText.text
            newItem.desc = descText.text
            newItem.itemTypeID = selectedPicker as NSNumber
            newItem.createdDate = NSDate()
            newItem.dueDate = dueDatePicker.date
            newItem.isCompleted = false
            newItem.completionDate = nil
            newItem.isDelete = false
        }
        
        // save context
                
        var error: NSError? = nil
        context.save(&error)
        if (error != nil) {
            println(error)
        }
        
        // navigate back to borrowed item list
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     * Type Picker View
     */
    
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
        // set selected item in picker view to typeList[row]
        selectedPicker = row
    }
}
