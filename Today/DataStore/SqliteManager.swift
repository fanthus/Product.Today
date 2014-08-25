//
//  SqliteManager.swift
//  Today
//
//  Created by xiushan.fan on 16/8/14.
//  Copyright (c) 2014年 Frank. All rights reserved.
//

import Foundation

var filePath:String?
let itemFile:String = "toitem"

class SqliteManager:NSObject {
    
    let tName:String = "records_table"
    
    init() {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        filePath =  documentsPath + "/" + itemFile
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

    func queryFromTable() -> [TDItem] {
        let fmdb:FMDatabase = FMDatabase(path:filePath as String)
        var resultArray:[TDItem] = [];
        if fmdb.open(){
            if fmdb.tableExists(tName) == false {
                self.createTable(filePath!)
            }
            let queryTableSql:String? = "select * from \(tName) order by _id asc"
            println(queryTableSql)
            var fmResult:FMResultSet = fmdb.executeQuery(queryTableSql, withArgumentsInArray: nil)
            while fmResult.next(){
                var item:TDItem = TDItem();
                item.itemDescription = fmResult.stringForColumn("recordDescription")
                item.itemTag = fmResult.stringForColumn("recordTag")
                item.itemStatus = ItemStatus.fromRaw(fmResult.intForColumn("recordFinished"))
                item.itemTimeStamp = fmResult.intForColumn("recordTimeStamp")
                item.itemId = fmResult.intForColumn("_id")
                resultArray.append(item)
            }
        }
        println("resultArray \(resultArray)")
        return resultArray;
    }
    
    func writeRecordToSqlite(item:TDItem) -> Bool{
        let fmdb:FMDatabase = FMDatabase(path:filePath as String)
        if fmdb.open(){
            if fmdb.tableExists(tName) == false {
                self.createTable(filePath!)
            }
            println(NSNumber(int: item.itemTimeStamp!))
            println(item.itemTag)
            println(item.itemDescription)
            let itemStatusInt:Int32 = ItemStatus.toRaw(item.itemStatus!)()
            let insertTableSql:String = "insert into \(tName)(recordTimeStamp,recordTag,recordFinished,recordDescription) values (?,?,?,?)"
            fmdb.executeUpdate(insertTableSql, NSNumber(int: item.itemTimeStamp!),item.itemTag!,NSNumber(int: itemStatusInt),item.itemDescription!)
        }
        fmdb.close()
        return true
    }
    
    func updateRecordToSqlite(item:TDItem) -> Bool{
        let fmdb:FMDatabase = FMDatabase(path: filePath as String)
        if fmdb.open(){
            if fmdb.tableExists(tName) == false{
                self.createTable(filePath!)
            }
            let updateTableSql:String = "update \(tName) set recordTag = '\(item.itemTag!)',recordFinished = \(item.itemStatus!.toRaw()),recordDescription = '\(item.itemDescription!)' where _id = \(item.itemId!)"
            var result:Bool = fmdb.executeUpdate(updateTableSql, withArgumentsInArray: nil)
            println(result)
        }
        return true
    }
}




