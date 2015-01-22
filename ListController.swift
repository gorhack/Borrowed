//
//  ListController.swift
//  Borrowed
//
//  Created by Kyle Gorak on 1/1/15.
//  Copyright (c) 2015 Kyle Gorak. All rights reserved.
//

import UIKit
import CoreData

class ListController: UITableViewController {
    var itemList = Array<AnyObject>()
    
    // Set context as the apps Managed Object Context
    
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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Add both edit and settings to navigation bar
        self.navigationItem.leftItemsSupplementBackButton = true;
        var editButton = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: nil);
        var settingsButton = UIBarButtonItem(title: "Settings", style: .Plain, target: self, action: nil);
        
        self.navigationItem.leftBarButtonItems = [editButton, settingsButton];
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // set up fetch request
        
        let context = managedObjectContext!
        let freq = NSFetchRequest(entityName: "ItemRecord")
        
        var error: NSError? = nil
        itemList = context.executeFetchRequest(freq, error: &error)!
        if error != nil {
            println(error)
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return itemList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        // Configure the cell...
        
        // cell identifier
        let cellID: NSString = "ItemCell"
        
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellID) as UITableViewCell
        
        // set data source
        var data: NSManagedObject = itemList[indexPath.row] as NSManagedObject
        
        // set cell labels
        cell.textLabel?.text = (data.valueForKeyPath("itemName") as String)
        cell.detailTextLabel?.text = (data.valueForKeyPath("desc") as String)
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Rename navigation controller's back button to cancel
        //self.navigationItem.title = "Cancel"
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let context = managedObjectContext!
        
        if editingStyle == .Delete {
            
            // Delete the row from the listView and data source
            
            context.deleteObject(itemList[indexPath.row] as NSManagedObject)
            itemList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            
            var error: NSError? = nil
            
            // Commit changes to data object
            
            if !context.save(&error) {
                abort()
            }
            //self.tableView.reloadData()
        } /*else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            
        } */
    }
    

    @IBOutlet weak var editTable: UIBarButtonItem!
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        if (editTable != nil) {
            let item: AnyObject = itemList[fromIndexPath.row]
            
            itemList.removeAtIndex(fromIndexPath.row)
            itemList.insert(item, atIndex: toIndexPath.row)
        }
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier? == "itemDetailSegue") {
            var selectedItem: NSManagedObject = itemList[self.tableView.indexPathForSelectedRow()!.row] as NSManagedObject
            
            let detailController = segue.destinationViewController as NewItemView
            
            // Pass values to the next view controller
            
            detailController.selectedItemName = selectedItem.valueForKey("itemName") as String
            detailController.selectedBorrowerName = selectedItem.valueForKey("borrowerName") as String
            detailController.selectedDescription = selectedItem.valueForKey("desc") as String
            detailController.selectedPicker = selectedItem.valueForKey("itemTypeID") as Int
            detailController.selectedDate = selectedItem.valueForKey("dueDate") as NSDate
            
            detailController.existingItem = selectedItem as NSManagedObject
            
            // Rename view controller back button to Cancel
            
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        }
    }
}
