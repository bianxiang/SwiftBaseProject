//
//  NumberUtils.swift
//  FindWork
//
//  Created by 1234 on 2016/11/3.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import UIKit
class NumberUtils {
    //MARK: - 评价分数
    static func toClearScore(num:Double) -> String {
        if Double(Int(num)) == num {
            return String(Int(num))
        }else{
            return String(format: "%.1f", num)
        }
        
    }
    
    //MARK: - 发单显示默认工作时间
    static func defaultWorkTime() -> String {
        var currentDay = NSDate()
        var timeStampN = Utils.timeStamp()
        var timeStampS = Utils.timeStamp()
        var dateStr = $.timeStampToString(timeStamp: timeStampS)
//        MM-dd HH:mm
        zp(dateStr)
        var hour = dateStr[Range(uncheckedBounds: (lower: 5, upper: 8))]!
        zp(hour)
        zp(hour.toInt()!)
        
        if let hourInt = hour.toInt() {
            if hourInt < 12 {
                //当日12点之前显示下一个小时
//                dateStr.replace(<#T##old: String##String#>, new: <#T##String#>)
                return String(Int(self.nextHourWithoutFenMiao().timeIntervalSince1970 * 1000))
            }else {
                //次日，显示7点
                var timeh = 60*60*(24-(hourInt - 7))
                let index:UInt = currentDay.minute()
                
                let inder1:Int = Int(bitPattern: index)
                var timem = Int(60 * inder1)
                var times = Int(bitPattern: currentDay.second()) 
                var timeIntervaldouble = Double(timeh - timem - times)
                var next7dian = Date(timeIntervalSinceNow: timeIntervaldouble)
                return String(Int(next7dian.timeIntervalSince1970 * 1000))
            }
        }
        
        return ""
    }
    
    static func showDistance(distance:Double) -> String {
        var s = ""
        if $.isIp5OrLess(){
            if distance < 1 {
                
                s = "距离您\(Int(distance*1000))m"
            }else {
                s = "距离您\(Int(distance))km"
            }
            
        }else{
            if distance < 1 {
                s = "零活距离您\(Int(distance*1000))m"
            }else {
                s = "零活距离您\(Int(distance))km"
            }
            
        }
        return s
    }
    
    
    
    
    
    
    
    
    static func nextHourWithoutFenMiao() -> Date {
        var gregorian = Calendar(identifier: .gregorian)
        var unitFlags:NSCalendar.Unit = [NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day, NSCalendar.Unit.hour, NSCalendar.Unit.minute]
        var components = gregorian.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.day,Calendar.Component.hour,Calendar.Component.minute,Calendar.Component.second], from: Date())
        var H = components.hour! + 1
        var MIN = components.minute!
        var SEC = components.second!
        zp(H)
        zp(MIN)
        zp(MIN)
        return Date(timeIntervalSinceNow: Double(3600-MIN*60-SEC))
    }
}
