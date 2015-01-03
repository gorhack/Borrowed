//
//  ItemDetailView.swift
//  Borrowed
//
//  Created by Kyle Gorak on 1/3/15.
//  Copyright (c) 2015 Kyle Gorak. All rights reserved.
//

import UIKit

class ItemDetailView: UIViewController {

    var itemSelected: ItemRecord?
    
    @IBOutlet weak var itemNameText: UITextField!
    @IBOutlet weak var borrowerNameText: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var typeIDText: UITextField!
    @IBOutlet weak var createdDateText: UITextField!
    @IBOutlet weak var dueDateText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println("detail view")
        println(itemSelected?.itemName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        itemNameText.text = itemSelected?.itemName
        borrowerNameText.text = itemSelected?.borrowerName
        descriptionText.text = itemSelected?.desc
        typeIDText.text = itemSelected?.itemTypeID as String
        createdDateText.text = itemSelected?.createdDate as String
        dueDateText.text = itemSelected?.dueDate as String
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
