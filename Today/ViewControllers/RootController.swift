//
//  ViewController.swift
//  Today
//
//  Created by xiushan.fan on 7/8/14.
//  Copyright (c) 2014年 Frank. All rights reserved.
//

import UIKit

class RootViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    var mainTableView:UITableView?;
    var dataStore:DataStore = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView = UITableView(frame:self.view.bounds, style: UITableViewStyle.Plain)
        self.view.addSubview(mainTableView)
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cellIdentifier:String = "identifyCell"
        var cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        
        return cell
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

