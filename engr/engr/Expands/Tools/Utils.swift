//
//  QueryData.swift
//  zuber
//
//  Created by duzhe on 15/10/17.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Utils{
    
    /**
     从文件中获取数据
     
     - parameter filename: 文件名
     
     - returns: NSData?
     */
    static func loadJSONFromBundle(_ filename: String) -> Data?  {
        if let path = Bundle.main.path(forResource: filename, ofType: "json") {
            let data:Data?
            do {
                data = try Data(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions())
                return data
            }catch let err {
                zp(err)
                return nil
            }
        } else {
            zp("Could not find file: \(filename)")
            return nil
        }
    }
    /**
     文字占的size
     
     - parameter str:  文字
     - parameter fontsize: 文字大小
     
     - returns: CGSize
     */
    static func sizeForIndexPath(_ str:NSString,fontsize:CGFloat,width:CGFloat = 300)->CGSize{
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: fontsize)]
        let size = str.boundingRect(with: CGSize(width: width, height: 2000), options: NSStringDrawingOptions.truncatesLastVisibleLine, attributes: attributes, context: nil).size
        return CGSize(width: size.width+20, height: size.height+10)
    }
    
    /**
     根据文字 确定label的宽度
     - returns: CGFloat
     */
    static func getTextRectSize(_ text:String,size:CGFloat) -> CGFloat {
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: size)]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = text.boundingRect(with: CGSize.zero, options: option, attributes: attributes, context: nil)
        return rect.width
    }
    
    static func getTextRectSize(_ str:String,attrs:[String:AnyObject],maxWid:CGFloat) -> CGSize {
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = str.boundingRect(with: CGSize(width: maxWid, height: 10000), options: option, attributes: attrs, context: nil)
        return rect.size
    }
    
    /**
     根据数组确定view的高度
     
     - parameter arr:  []
     - parameter wid:  高度
     - parameter size: fontsize
     
     - returns: CGFloat
     */
    static func getHeightByArr(_ arr:[String],wid:CGFloat,size:CGFloat)->CGFloat{
        let h_padding:CGFloat = 7
        var rows:CGFloat = 1   //行数
        var rowWidth:CGFloat = h_padding
        
        for i in 0..<arr.count{
            let lb = UILabel()
            lb.text = arr[i]
            lb.font = UIFont.systemFont(ofSize: size)
            lb.tag = 100+i
            let lbWidth = getTextRectSize(lb.text!,size: size)+20
            rowWidth += lbWidth + h_padding
            
            if rowWidth > wid {
                rows += 1
                rowWidth = h_padding + lbWidth
            }
            
        }
        return rows
    }
    
    /**
     得到行高
     
     - parameter arr:  [String]
     - parameter wid:  CGFloat
     - parameter size: CGFloat
     
     - returns: CGFloat
     */
    static func getRowHeigetByArr(_ arr:[String],wid:CGFloat,size:CGFloat)->CGFloat{
        let h_padding:CGFloat = 5
        var rows:CGFloat = 1   //行数
        var rowWidth:CGFloat = h_padding
        
        for i in 0..<arr.count{
            let lb = UILabel()
            lb.text = arr[i]
            lb.font = UIFont.systemFont(ofSize: size)
            lb.tag = 100+i
            let lbWidth = getTextRectSize(lb.text!,size: size)+10
            rowWidth += lbWidth + h_padding
            
            if rowWidth > wid {
                rows += 1
                rowWidth = h_padding + lbWidth
            }    
        }
        return (rows+1)*h_padding+rows*__$.TAG_HEIGHT
    }
    
    /**
     NSMutableArray 转成 [String]
     
     - parameter arr: NSMutableArray
     
     - returns: [String]
     */
    static func arrToString(_ arr:NSMutableArray)->[String]{
        
        var strs:[String] = []
        for item in arr{
            strs.append(item as! String)
        }
        return strs
    }
    
       /**
     获得当前时间的时间戳
     
     - returns: String
     */
    static func timeStamp()->String{
        let date = Date(timeIntervalSinceNow: 0)
        zp("================================当前时间\(date)====\(Date())====\(Date(timeIntervalSince1970: 0))")
        let interval = date.timeIntervalSince1970
        return "\(Int(interval*1000))"
    }
    
    static func timeStampNum()->TimeInterval{
        let date = Date(timeIntervalSinceNow: 0)
        let interval = date.timeIntervalSince1970
        return interval
    }
    
    // n天后
    static func nDaysLater(n:Int)->String{
        let newDate = Date()
        let nDaysDate = Date(timeInterval: Double(60*60*24*n), since: newDate)
        print("时间 \(nDaysDate)")
        let interval = nDaysDate.timeIntervalSince1970
        return "\(Int(interval*1000))"
    }
    
    
    /**
     验证手机的正则
     
     - parameter matchStr: String
     
     - returns: Bool
     */
    static func checkTel(_ matchStr:String?) -> Bool{
        guard let matchStr = matchStr else {return false}
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{ return false }
        guard let vc = appDelegate.activityViewController() else{return false}
        
        if $.k(matchStr) {
            ZZAlert.showAlert(vc, meg:"手机号不能为空")
            return false
        }
        if matchStr.substringToIndex(1) != "1"{
            ZZAlert.showAlert(vc, meg:ZT.phoneFromatWrong)
            return false
        }else if matchStr.length != 11{
            ZZAlert.showAlert(vc, meg:ZT.phoneFromatWrong)
            return false
        }
        let regex = "^\\s*\\+?\\s*(\\(\\s*\\d+\\s*\\)|\\d+)(\\s*-?\\s*(\\(\\s*\\d+\\s*\\)|\\s*\\d+\\s*))*\\s*$"  //验证电话号码正则
        do {
            let matcher = try RegexHelper(regex)
            if matcher.match(matchStr) {
                return true
            }else{
                ZZAlert.showAlert(vc, meg:ZT.phoneFromatWrong)
                return false
            }
        }catch let err{
            zp(err)
            return false
        }
    }
}
