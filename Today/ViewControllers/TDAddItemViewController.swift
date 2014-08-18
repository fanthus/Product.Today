//
//  TDAddItemViewController.swift
//  Today
//
//  Created by xiushan.fan on 17/8/14.
//  Copyright (c) 2014年 Frank. All rights reserved.
//

import Foundation

class TDAddItemViewController:TDBaseViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayColor()
        self.title = NSLocalizedString("Add Record", comment: "")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "addRecord:")
    }
    
    func addRecord(sender:AnyObject){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
