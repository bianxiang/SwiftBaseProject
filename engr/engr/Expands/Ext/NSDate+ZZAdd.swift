//
//  NSDate+ZZAdd.swift
//  zuber
//
//  Created by duzhe on 16/6/12.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import Foundation

extension Date{
    
    /**
      根据字符串获取date 字符串类型 "yyyy-MM-dd"
     
     - parameter dateString: 日期字符串
     
     - returns: date
     */
    static func getDateFromStr(_ dateString:String?)->Date?{
        guard let str = dateString else
        {
            return Date()
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: str)
    }
    
    
    /**
     格式化日期 默认  "yyyy-MM-dd"
     也可以自己提供
     
     - parameter str: 格式
     
     - returns: 格式化后日期的string类型
     */
    func format(_ str:String? = nil) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = str ?? "yyyy-MM-dd"
        return dateFormatter.string(from: self)   
    }
    
    /**
     n 天以后
     
     - parameter n: 天数
     
     - returns: date
     */
    func advance(_ n:Int)->Date{
        return  Date(timeInterval:Double(60*60*24*n), since: self)
    }
    
    
    
}
