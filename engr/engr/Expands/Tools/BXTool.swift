//
//  BXTool.swift
//  WeixinMemberCard
//
//  Created by WANG FEI on 16/5/4.
//  Copyright © 2016年 iAnonymous. All rights reserved.
//

import UIKit

public enum BXDateFormat : String {
    
    /// 日期转字符串"yyyy/MM/dd"
    case Sprit = "yyyy/MM/dd"
    ///日期转字符串"yyyy-MM-dd"
    case Rank = "yyyy-MM-dd"
    ///日期转字符串"yyyy-MM-dd  HH:mm:ss"
    case RankSecond = "yyyy-MM-dd HH:mm:ss"
    
}
public enum BXPermission : Int {
    /// 可见
    case Visible = 1
    
    /// 可读
    case Readable = 2
    
    ///可写
    case Writeable = 4
    
}


@objc(BXTool)
class BXTool: NSObject {
    
    
    
    typealias DidConnected = () -> Void
//    var didConnected : DidConnected?
    
    typealias Success = () -> Void
//    var success : Success?
    
    typealias Finish = () -> Void
    
    
    
    /**
     日期转字符串"yyyy/MM/dd"
     */
    static func dateToStr(date:Date ) -> String{
//        let df = NSDateFormatter()
//        df.dateFormat = "yyyy/MM/dd"
//        let str = df.stringFromDate(date)
//        return str
        return BXTool.stringWithDate(date: date as Date, dateFormat: .Sprit)
    }
    /**
     日期转字符串"yyyy-MM-dd"
     */
    static func dateToStr_(date:Date ) -> String{
//        let df = NSDateFormatter()
//        df.dateFormat = "yyyy-MM-dd"
//        let str = df.stringFromDate(date)
//        return str
        
        return BXTool.stringWithDate(date: date, dateFormat: .Rank)
    }
    /**
     日期转字符串"yyyy-MM-dd  HH:mm:ss"
     */
    static func dateToStr_yyyy_MM_dd_HH_mm_ss(date:Date ) -> String{
//        let df = NSDateFormatter()
//        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let str = df.stringFromDate(date)
//        return str
        return BXTool.stringWithDate(date: date, dateFormat: .RankSecond)
    }
    
    static func dateAfterToday(afterFewDays:Double) -> NSDate {
        return NSDate(timeIntervalSinceNow: 3600*24*afterFewDays)
    }
    
    
    static func stringWithDate(date:Date,dateFormat:BXDateFormat) -> String {
        
        let df = DateFormatter()
        df.dateFormat = dateFormat.rawValue
        let str = df.string(from: date as Date)
        return str
        
    }
    
    static func dateWithString(dateString:String) -> Date{
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        
        return df.date(from: dateString)! as Date
    }
        
        
    /**
     把字典排序成2个有序的键值数组
     */
    static func sortDict(dict:[String:NSNumber]) -> (keys :[String], values :[NSNumber]) {
        var keys =  Array(dict.keys)
        keys.sort(by: { (s1, s2) -> Bool in
            return s1 < s2
        })
        print(keys)
        
        var values = [NSNumber]()
        for key in keys {
            values.append(dict[key]!)
        }
        print(values)
        return (keys:keys,values:values)
    }
    
   
    
    /**
     隐藏导航线
     */
    static func hideNavLine(nav:UINavigationController)  {
        
        let bar = nav.navigationBar
        // bg.png为自己ps出来的想要的背景颜色。
        bar.setBackgroundImage(UIImage(named: "bg"), for: .any, barMetrics: .default)
        bar.shadowImage = UIImage()
        
    }
    
    
    
    
    
    
    static func checkPermissions(mask:Int , permission:BXPermission) -> Bool {
        if (mask & permission.rawValue) != 0{
           
            return true
        }else {
            
            return false
        }
    }
  
    
    
    
    
    
    static func formatPrice(price:Double) -> String {
        return String(format: "%.2f",price)
    }
    
    
    
    
}
