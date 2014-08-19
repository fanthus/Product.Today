//
//  SqliteManager.swift
//  Today
//
//  Created by xiushan.fan on 16/8/14.
//  Copyright (c) 2014年 Frank. All rights reserved.
//

import Foundation

var filePath:String?
let metaRecordFile:String = "metaRecord"

class SqliteManager:NSObject {
    
    let tName:String = "records"
    
    init() {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        filePath =  documentsPath + "/" + metaRecordFile
        println("filepath = \(filePath)")
    }
    
    func createSqliteFile() -> Bool{
        if(self.haveSqliteFile()){
            return true;
        }
        else{
            var fileManager:NSFileManager = NSFileManager.defaultManager();
            fileManager.createFileAtPath(filePath as String, contents: nil, attributes: nil)
        }
        return true
    }
    
    func haveSqliteFile()->Bool{
        return false;
    }
    
    func writeRecordToSqlite(metaRecord:MetaRecord) -> Bool{
        let fmdb:FMDatabase = FMDatabase(path:filePath as String)
        if fmdb.open(){
            if fmdb.tableExists(tName){
                let insertTableSql:String? = "insert into \(tName) (recordId,recordTimeStamp,recordTag,recordStatus,recordDescription) values (\(metaRecord.recordId),\(metaRecord.recordTimeStamp),\(metaRecord.recordTag),\(metaRecord.recordStatus),\(metaRecord.recordDescription))"
                println (fmdb.executeUpdate(insertTableSql, withArgumentsInArray: nil))
            }
            else{
                let createTableSql:String? = "create table \(tName) (recordId int,recordTimeStamp int,recordTag text,recordStatus bool,recordDescription text)";
                fmdb.executeUpdate(createTableSql, withArgumentsInArray: nil)
            }
        }
        
        return true
    }
    
}

