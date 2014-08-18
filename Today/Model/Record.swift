//
//  File.swift
//  Today
//
//  Created by xiushan.fan on 18/8/14.
//  Copyright (c) 2014年 Frank. All rights reserved.
//

import Foundation

enum RecordStatus:Int{
    case RecordFinshed = 1,RecordUnfinished
}

class Record:NSObject{
    var recordDescription:String?
    var recordId:Int32?
    var recordTimeStamp:Double?
    var recordTag:String?
    var recordStatus:RecordStatus?
}
