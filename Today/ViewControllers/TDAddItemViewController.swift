//
//  TDAddItemViewController.swift
//  Today
//
//  Created by xiushan.fan on 17/8/14.
//  Copyright (c) 2014年 Frank. All rights reserved.
//

import Foundation

class TDAddItemViewController:TDBaseViewController,UITextFieldDelegate{
    var metaRecordField:UITextField = UITextField();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayColor()
        self.title = NSLocalizedString("New", comment: "")
        self.edgesForExtendedLayout = UIRectEdge.None;
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancel:");
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "save:")
        metaRecordField = UITextField(frame: CGRectMake(0, 0, 320, 50));
        metaRecordField.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(metaRecordField)
    }
    
    func cancel(sender:AnyObject){
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func save(sender:AnyObject){
        let record:TDItem = TDItem()
        record.itemId = 1
        record.itemDescription = metaRecordField.text
        record.itemTag = "testTag"
        record.itemStatus = ItemStatus.ItemUnfinished
        record.itemTimeStamp = Int32(NSTimeIntervalSince1970)
        DataStore.sharedInstance.sqliteManager.writeRecordToSqlite(record)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //---------------------------------
    
    
    //---------------------------------
    func textFieldShouldBeginEditing(textField: UITextField!) -> Bool {
        return true
    }
    
    
    
}
