//
//  MetamindViewController.swift
//  Today
//
//  Created by xiushan.fan on 25/8/14.
//  Copyright (c) 2014年 Frank. All rights reserved.
//

import Foundation

class MetaMindViewController:TDBaseViewController,UITableViewDelegate,UITableViewDataSource{
    
    let cellIdentifier:String = "cell"
    let firstSectionArray:[String] = ["Inbox"]
    let secondSectionArray:[String] = ["Today","Later"]
    let thirdSectionArray:[String] = ["Calendar","Projects","Area of Responsibility"]
    let forthSectionArray:[String] = ["Someday","Logbook"]
    var displayNamesArray:Array<Array<String>> = [Array]()
    var displayHeaderArray:Array<String> = ["Collect","PROCESS","ORGANIZE","REVIEW"]
    
    override func viewDidLoad() {
        //
        self.title = NSLocalizedString("MetaMind", comment: "")
        var metaTableView:UITableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.Grouped)
        metaTableView.delegate = self
        metaTableView.dataSource = self
        self.view.addSubview(metaTableView)
        metaTableView.registerClass(TDItemCell.self, forCellReuseIdentifier: self.cellIdentifier)
        displayNamesArray.append(firstSectionArray)
        displayNamesArray.append(secondSectionArray)
        displayNamesArray.append(thirdSectionArray)
        displayNamesArray.append(forthSectionArray)
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel.text = self.displayInCell(indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        if indexPath == NSIndexPath(forRow: 0, inSection: 0){
            let inboxVC:InboxViewController = InboxViewController()
            self.navigationController.pushViewController(inboxVC, animated: true)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func displayInCell(indexPath:NSIndexPath!) -> String {
        var rowNamesArray:[String] = displayNamesArray[indexPath.section]
        return rowNamesArray[indexPath.row]
    }
    
    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        return displayHeaderArray[section]
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        var rowNum:Int = 0
        rowNum = displayNamesArray[section].count
        return rowNum;
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return displayNamesArray.count
    }
}

