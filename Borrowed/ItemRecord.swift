//
//  ItemRecord.swift
//  Borrowed
//
//  Created by Kyle Gorak on 12/28/14.
//  Copyright (c) 2014 Kyle Gorak. All rights reserved.
//

import UIKit
import CoreData

@objc(ItemRecord)
class ItemRecord: NSManagedObject {
    
    // define properties
    
    @NSManaged var itemName: String
    @NSManaged var borrowerName: String
    @NSManaged var itemTypeID: NSNumber
    @NSManaged var desc: String?
    @NSManaged var createdDate: NSDate
    @NSManaged var dueDate: NSDate?
    @NSManaged var isCompleted: NSNumber
    @NSManaged var completionDate: NSDate?
    @NSManaged var isDelete: NSNumber
   
}
