//
//  UserSetting.swift
//  Today
//
//  Created by xiushan.fan on 15/8/14.
//  Copyright (c) 2014年 Frank. All rights reserved.
//

import Foundation

let firstInstallKey:String = "firstInstallKey"


class UserSetting:NSObject{
    var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    func setFirstInstallValue(value:Bool){
        userDefaults.setBool(value, forKey:firstInstallKey)
    }
    func firstInstallValue() -> Bool{
        return userDefaults.boolForKey(firstInstallKey)
    }
    
}