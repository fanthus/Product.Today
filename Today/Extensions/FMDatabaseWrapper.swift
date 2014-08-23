//
//  FMDatabaseWrapper.swift
//  Today
//
//  Created by xiushan.fan on 21/8/14.
//  Copyright (c) 2014年 Frank. All rights reserved.
//

import Foundation

extension FMDatabase {
    
    /// This is rendition of executeQuery that handles Swift variadic parameters
    /// for the values to be bound to the ? placeholders in the SQL.
    ///
    /// :param: sql The SQL statement to be used.
    /// :param: values The values to be bound to the ? placeholders
    ///
    /// :returns: This returns FMResultSet if successful. Returns nil upon error.
    
    func executeQuery(sql:String, _ values: AnyObject...) -> FMResultSet? {
        return executeQuery(sql, withArgumentsInArray: values as NSArray);
    }
    
    /// This is rendition of executeUpdate that handles Swift variadic parameters
    /// for the values to be bound to the ? placeholders in the SQL.
    ///
    /// :param: sql The SQL statement to be used.
    /// :param: values The values to be bound to the ? placeholders
    ///
    /// :returns: This returns true if successful. Returns false upon error.
    
    func executeUpdate(sql:String, _ values: AnyObject...) -> Bool {
        return executeUpdate(sql, withArgumentsInArray: values as NSArray);
    }
}