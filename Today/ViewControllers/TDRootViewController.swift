//
//  ViewController.swift
//  Today
//
//  Created by xiushan.fan on 7/8/14.
//  Copyright (c) 2014年 Frank. All rights reserved.
//

import UIKit

class RootViewController:TDBaseViewController,UITableViewDelegate,UITableViewDataSource{

    var mainTableView:UITableView?;
    let cellIdentifier:String = "cell"
    var dataStore:DataStore = DataStore.sharedInstance
    var recordArray:[MetaRecord] = [MetaRecord]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Hello", comment:"")
        let rightItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action:"enterAddVC")
        self.navigationItem.rightBarButtonItem = rightItem
        mainTableView = UITableView(frame:self.view.bounds, style: UITableViewStyle.Plain)
        mainTableView!.delegate = self
        mainTableView!.dataSource = self
        self.view.addSubview(mainTableView)
        mainTableView!.registerClass(MetaRecordCell.self, forCellReuseIdentifier: self.cellIdentifier)
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        recordArray = DataStore.sharedInstance.sqliteManager.queryFromTable()
        println(recordArray)
        mainTableView!.reloadData()
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        println("tableView = \(tableView)")
        println("cellIdentifier = \(self.cellIdentifier)")
        var cell:MetaRecordCell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as MetaRecordCell
        var btn:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        btn.setBackgroundImage(UIImage(named: "checkbox-unselected"), forState:UIControlState.Normal)
        btn.addTarget(self, action: "selectBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        btn.frame = CGRectMake(18, 18, 24, 24)
        btn.tag = indexPath.row
        cell.addSubview(btn)
        
        var label:UILabel = UILabel(frame: CGRectMake(55, 0, 240, 60))
        cell.addSubview(label)

        if indexPath.row < recordArray.count{
            label.text = recordArray[indexPath.row].recordDescription
        }
        return cell
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 60.0
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return recordArray.count;
    }
    
    func tableView(tableView: UITableView!, shouldHighlightRowAtIndexPath indexPath: NSIndexPath!) -> Bool{
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func selectBtn(btn:UIButton){
        btn.selected = !btn.selected
        var record:MetaRecord = recordArray[btn.tag]
        if btn.selected{
            btn.setBackgroundImage(UIImage(named: "checkbox-selected"), forState: UIControlState.Normal)

            record.recordFinished = 1
        }
        else{
            btn.setBackgroundImage(UIImage(named: "checkbox-unselected"), forState: UIControlState.Normal)
            record.recordFinished = 0
        }
        DataStore.sharedInstance.sqliteManager.updateRecordToSqlite(record)
    }
    
    func enterAddVC(){
        let addItemVC:TDAddItemViewController = TDAddItemViewController()
        let addItemNav:UINavigationController = UINavigationController(rootViewController: addItemVC)
        self.presentViewController(addItemNav, animated: true, completion:nil)
    }
}

