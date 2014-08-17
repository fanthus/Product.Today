//
//  SqliteManager.swift
//  Today
//
//  Created by xiushan.fan on 16/8/14.
//  Copyright (c) 2014年 Frank. All rights reserved.
//

import Foundation

class SqliteManager:NSObject {
    
    
    func createSqliteFile() -> Bool{
        if(self.haveSqliteFile()){
            return true;
        }
        else{
            var fileManager:NSFileManager = NSFileManager.defaultManager();
            var filePath:AnyObject = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            println("Document path =  + \(filePath)")
        }
        return true
    }
    
    func haveSqliteFile()->Bool{
        return false;
    }
}

