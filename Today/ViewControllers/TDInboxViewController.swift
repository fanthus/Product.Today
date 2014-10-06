//
//  ViewController.swift
//  Today
//
//  Created by xiushan.fan on 7/8/14.
//  Copyright (c) 2014年 Frank. All rights reserved.
//

import UIKit

class InboxViewController: TDBaseViewController, UITableViewDelegate, UITableViewDataSource,TDItemCellDelegate{

    var tableView:UITableView?;
    let cellIdentifier:String = "cell"
    var dataStore:DataStore = DataStore.sharedInstance
    var recordArray:[TDItem] = [TDItem]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Hello", comment:"")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action:"enterAddVC")
        tableView = UITableView(frame:self.view.bounds, style: UITableViewStyle.Plain)
        tableView!.delegate = self
        tableView!.dataSource = self
        self.view.addSubview(tableView!)
        tableView!.registerClass(TDItemCell.self, forCellReuseIdentifier: self.cellIdentifier)
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        recordArray = DataStore.sharedInstance.sqliteManager.queryFromTable()
        println(recordArray)
        tableView!.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:TDItemCell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as TDItemCell
        cell.delegate = self;
        cell.checkBoxBtn!.addTarget(self, action: "selectBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.checkBoxBtn!.tag = indexPath.row

        cell.label!.text = recordArray[indexPath.row].itemDescription
        cell.addSubview(cell.label!)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell:TDItemCell = tableView.cellForRowAtIndexPath(indexPath)! as TDItemCell
        cell.delegate?.selectCell()
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 60.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordArray.count
    }
    
    func tableView(tableView: UITableView!, shouldHighlightRowAtIndexPath indexPath: NSIndexPath!) -> Bool{
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func selectBtn(btn:UIButton){
        btn.selected = !btn.selected
        var record:TDItem = recordArray[btn.tag]
        if btn.selected{
            btn.setBackgroundImage(UIImage(named: "checkbox-selected"), forState: UIControlState.Normal)
            record.itemStatus = ItemStatus.ItemFinished
        }
        else{
            btn.setBackgroundImage(UIImage(named: "checkbox-unselected"), forState: UIControlState.Normal)
            record.itemStatus = ItemStatus.ItemUnfinished
        }
        DataStore.sharedInstance.sqliteManager.updateRecordToSqlite(record)
    }
    
    func enterAddVC(){
        let addItemVC:TDAddItemViewController = TDAddItemViewController()
        let addItemNav:UINavigationController = UINavigationController(rootViewController: addItemVC)
        self.presentViewController(addItemNav, animated: true, completion:nil)
    }
    
    func selectCell() {
        println("select cell ");
    }
}

