//
//  DataStore.swift
//  Today
//
//  Created by xiushan.fan on 7/8/14.
//  Copyright (c) 2014年 Frank. All rights reserved.
//

import Foundation

private let _sharedInstance:DataStore = DataStore()

class DataStore:NSObject {
    var userSetting:UserSetting = UserSetting();
    var sessionSetting:SessionSetting = SessionSetting();
    var sqliteManager:SqliteManager = SqliteManager();
    
    //singleton
    class var sharedInstance:DataStore {
        return _sharedInstance
    }
}
