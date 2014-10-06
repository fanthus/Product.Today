//
//  MetaRecordCell.swift
//  Today
//
//  Created by xiushan.fan on 23/8/14.
//  Copyright (c) 2014年 Frank. All rights reserved.
//

import Foundation

protocol TDItemCellDelegate {
    func selectCell();
}

class TDItemCell:UITableViewCell{
    var label:UILabel?
    var checkBoxBtn:CheckBoxButton?
    var delegate:TDItemCellDelegate?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.checkBoxBtn = CheckBoxButton();
        self.checkBoxBtn!.frame = CGRectMake(18, 18, 24, 24)
        self.checkBoxBtn!.addTarget(self, action:"check:", forControlEvents: UIControlEvents.TouchUpInside)
        self.checkBoxBtn!.setBackgroundImage(UIImage(named: "checkbox-unselected"), forState:UIControlState.Normal)
        self.addSubview(checkBoxBtn!)
        
        self.label = UILabel(frame: CGRectMake(55, 0, 240, 60))
        self.addSubview(self.label!);
    }
    
    func check(button:UIButton){
        println("check ")
    }
}
