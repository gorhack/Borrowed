//
//  NewItemView.swift
//  Borrowed
//
//  Created by Kyle Gorak on 12/30/14.
//  Copyright (c) 2014 Kyle Gorak. All rights reserved.
//

import UIKit
import CoreData

class NewItemView: UIViewController {

    
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
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(sender: AnyObject) {
        // reference managed object context
        
        let context = managedObjectContext!
        let en = NSEntityDescription.entityForName("ItemRecord", inManagedObjectContext: context)
        
        // create instance of data model
        
        var newItem = ItemRecord(entity: en!, insertIntoManagedObjectContext: context)
        
        // save data to core data
        
        newItem.itemName = itemNameText.text
        newItem.borrowerName = borrowerNameText.text
        newItem.desc = descText.text
        newItem.itemTypeID = 0
        newItem.createdDate = NSDate()
        newItem.dueDate = dueDatePicker.date
        newItem.isCompleted = false
        newItem.completionDate = nil
        newItem.isDelete = false
        
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
