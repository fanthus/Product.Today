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
    
    let tName:String = "records_table"
    
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
        let fileManager:NSFileManager = NSFileManager.defaultManager()
        return fileManager.fileExistsAtPath(filePath);
    }
    
    func createTable(sqfilePath:String) -> Bool{
        let fmdb:FMDatabase = FMDatabase(path:sqfilePath as String)
        if fmdb.open(){
            let createTableSql:String? = "create table \(tName) (_id integer primary key autoincrement,recordTimeStamp int,recordTag text,recordFinished bool,recordDescription text)";
            fmdb.executeUpdate(createTableSql, withArgumentsInArray: nil)
        }
        return true
    }
    
    //----------------------------------------------------------------------

    func queryFromTable() -> [MetaRecord] {
        let fmdb:FMDatabase = FMDatabase(path:filePath as String)
        var resultArray:[MetaRecord] = [];
        if fmdb.open(){
            if fmdb.tableExists(tName) == false {
                self.createTable(filePath!)
            }
            let queryTableSql:String? = "select * from \(tName) order by _id asc"
            println(queryTableSql)
            var fmResult:FMResultSet = fmdb.executeQuery(queryTableSql, withArgumentsInArray: nil)
            while fmResult.next(){
                var metaRecord:MetaRecord = MetaRecord();
                metaRecord.recordDescription = fmResult.stringForColumn("recordDescription")
                metaRecord.recordTag = fmResult.stringForColumn("recordTag")
                metaRecord.recordFinished = fmResult.intForColumn("recordFinished")
                metaRecord.recordTimeStamp = fmResult.intForColumn("recordTimeStamp")
                metaRecord.recordId = fmResult.intForColumn("_id")
                resultArray.append(metaRecord)
            }
        }
        println("resultArray \(resultArray)")
        return resultArray;
    }
    
    func writeRecordToSqlite(metaRecord:MetaRecord) -> Bool{
        let fmdb:FMDatabase = FMDatabase(path:filePath as String)
        if fmdb.open(){
            if fmdb.tableExists(tName) == false {
                self.createTable(filePath!)
            }
            println(NSNumber(int: metaRecord.recordTimeStamp!))
            println(metaRecord.recordTag)
            println(metaRecord.recordDescription)
            let insertTableSql:String = "insert into \(tName)(recordTimeStamp,recordTag,recordFinished,recordDescription) values (?,?,?,?)"
            fmdb.executeUpdate(insertTableSql, NSNumber(int: metaRecord.recordTimeStamp!),metaRecord.recordTag!,NSNumber(int: metaRecord.recordFinished!),metaRecord.recordDescription!)
        }
        fmdb.close()
        return true
    }
    
    func updateRecordToSqlite(metaRecord:MetaRecord) -> Bool{
        let fmdb:FMDatabase = FMDatabase(path: filePath as String)
        if fmdb.open(){
            if fmdb.tableExists(tName) == false{
                self.createTable(filePath!)
            }
            let updateTableSql:String = "update \(tName) set recordTag = '\(metaRecord.recordTag!)',recordFinished = \(metaRecord.recordFinished!),recordDescription = '\(metaRecord.recordDescription!)' where _id = \(metaRecord.recordId!)"
            var result:Bool = fmdb.executeUpdate(updateTableSql, withArgumentsInArray: nil)
            println(result)
        }
        return true
    }
}




