//
//  CommonProperty.swift
//  zuber
//
//  Created by duzhe on 15/11/15.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias _z = CommonProperty

class CommonProperty{
    
    static var current_city:String?
    
    /**
     替换空字串
     
     - parameter str:String?
     - parameter insteadStr: String
     
     - returns: String
     */
    static func isNil(_ str:String?,insteadStr:String) ->String{
        if let str = str{
            return str
        }else{
            return insteadStr
        }
    }
    
    static func isNilorEmpty(_ str:String?)->String?{
    
        if let str = str{
            if str != ""{
                return str
            }
        }
        return nil
    }
    
    static func isNil(_ i:NSNumber?)->NSNumber{
        if let i = i{
            return i
        }
        return 0
    }
    
    static func arrayToString(_ arrs:[String])->String{
        var ids = ""
        for str in arrs{
            ids += "\(str),"
        }
        if ids.characters.count>0{
            ids = (ids as NSString).substring(to: ids.characters.count - 1)
        }
       return ids
    }
    
    /**
     获取当前年月日
     
     - returns: (Int,Int,Int)
     */
    static func getYMD()->(Int,Int,Int){
        let dateFormatter:DateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyyy/MM/dd";
        let dateString:String = dateFormatter.string(from: Date());
        let dates:[String] = dateString.components(separatedBy: "/")
        return (Int(dates[0])!,Int(dates[1])!,Int(dates[1])!)
    }
    
    static func getNextMoth(_ y:Int,_ m:Int)->(Int,Int){
        if m == 12{
            return (y+1,1)
        }else{
            return (y,m+1)
        }
    }
    
    //当月后n个月
    static func getMonthN(_ y:Int,_ m:Int,n :Int)->String{
        if m + n > 12{
            return "\(y+1)-\(m+n-12)-01"
        }else{
            return "\(y)-\(m+n)-01"
        }
    }
    
    static func isNullOrEmpty(_ str:String?)->Bool{
        if str == nil || str == ""{
            return true
        }
        return false
    }

    static func setAtrributeText(_ attr:NSAttributedString?,insteadStr:String)->NSMutableAttributedString?{
        guard let attr = attr else { return nil}
        let attributedString = attr.mutableCopy() as! NSMutableAttributedString
        let first_attr = [NSFontAttributeName:UIFont.boldSystemFont(ofSize: 14)]
        
        attributedString.addAttributes(first_attr, range:  (attributedString.string as NSString).range(of: insteadStr))
        return attributedString
    }
    
    static func setAtrributeText(_ str:String,insteadStr:String)->NSMutableAttributedString?{
        let attributedString = NSMutableAttributedString(string: str)
        let first_attr = [NSFontAttributeName:UIFont.boldSystemFont(ofSize: 14)]
        attributedString.addAttributes(first_attr, range: (attributedString.string as NSString).range(of: insteadStr))
        return attributedString
    }
    
    static func toJSONString(_ dict:[String: Any ])->String?{
        guard let data = try? JSONSerialization.data(withJSONObject: dict , options: JSONSerialization.WritingOptions.prettyPrinted) else { return nil }
        guard let str = String(data: data, encoding: String.Encoding.utf8) else { return nil }
        return str
    }
    
}
