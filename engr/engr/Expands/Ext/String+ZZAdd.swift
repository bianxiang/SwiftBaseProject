//
//  StringExt.swift
//  zuber
//
//  Created by duzhe on 15/11/13.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

extension String{
    
    //拿到描述
    func toDetailString()->String{
        guard let index1 = self.characters.index(of: ",") else { return "" }
        guard let index2 = self.characters.index(of: "@") else { return "" }
        
        let startIndex = self.index(after: index1)
        let endIndex = self.index(before: index2)
        
        let range = Range<String.Index>(startIndex ..< endIndex)
        return self.substring(with: range)
     }
    
    //替换br
    func replaceBR()->String{
        var tmpStr = self
        tmpStr = tmpStr.replace("&amp;", new: "&")
        tmpStr = tmpStr.replace("amp;", new: "&")
        tmpStr = tmpStr.replace("#039", new: "")
        tmpStr = tmpStr.replace("&quot;", new: "\"")
        tmpStr = tmpStr.replace("&#039;", new: "'")
        tmpStr = tmpStr.replace("&lt;", new: "<")
        tmpStr = tmpStr.replace("&gt;", new: ">")
        tmpStr = tmpStr.replace("<br>", new: "\r\n")
        return tmpStr
    }
    
    /**
     字符串长度
     */
    public var length:Int{
        get{
            return self.characters.count
        }
    }
    
    /**
     是否包含某个字符串
     
     - parameter s: 字符串
     
     - returns: bool
     */
    func has(_ s:String)->Bool{
        if self.range(of: s) != nil {
            return true
        }else{
            return false
        }
    }
    
    /**
     分割字符
     
     - parameter s: 字符
     
     - returns: 数组
     */
    func split(_ s:String)->[String]{
        if s.isEmpty{
            return []
        }
        return self.components(separatedBy: s)
    }
    
    /**
     去掉左右空格
     
     - returns: string
     */
    func trim()->String{
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    /**
     字符串替换
     
     - parameter old: 旧字符串
     - parameter new: 新字符串
     
     - returns: 替换后的字符串
     */
    func replace(_ old:String,new:String)->String{
        return self.replacingOccurrences(of: old, with: new, options: NSString.CompareOptions.numeric, range: nil)
    }
    
    /**
     substringFromIndex  int版本
     
     - parameter index: 开始下标
     
     - returns: 截取后的字符串
     */
    func substringFromIndex(_ index:Int)->String{
        let startIndex = self.characters.startIndex
        
        
        return  self.substring(from: self.characters.index(startIndex, offsetBy: index) )
//        return self.substring(from: <#T##String.CharacterView corresponding to `startIndex`##String.CharacterView#>.index(startIndex, offsetBy: index))
    }
    
    /**
     substringToIndex int版本
     
     - parameter index: 介绍下标
     
     - returns: 截取后的字符串
     */
    func substringToIndex(_ index:Int)->String{
        let startIndex = self.characters.startIndex
        
        
        return self.substring(to : self.characters.index(startIndex, offsetBy: index) )
        
//        return self.substring(to: <#T##String.CharacterView corresponding to `startIndex`##String.CharacterView#>.index(startIndex, offsetBy: index))
    }
    
    /**
     substringWithRange int版本
     
     - parameter start: 开始下标
     - parameter end:   结束下标
     
     - returns: 截取后的字符串
     */
//    func substringWithRange(_ start:Int,end:Int)->String{
//        let startIndex = self.characters.startIndex
//        let range = Range( <#T##String.CharacterView corresponding to `startIndex`##String.CharacterView#>.index(startIndex, offsetBy: start) ... <#T##String.CharacterView corresponding to `startIndex`##String.CharacterView#>.index(startIndex, offsetBy: end))
//        return self.substring(with: range)
//    }
    
    /**
     去掉左空格
     */
    func trimmedLeft (characterSet set: CharacterSet = CharacterSet.whitespacesAndNewlines) -> String {
        if let range = rangeOfCharacter(from: set.inverted) {
            return self[range.lowerBound..<endIndex]
        }
        return ""
    }
    /**
     去掉右空格
     */
    func trimmedRight (characterSet set: CharacterSet = CharacterSet.whitespacesAndNewlines) -> String {
        if let range = rangeOfCharacter(from: set.inverted, options: NSString.CompareOptions.backwards) {
            return self[startIndex..<range.upperBound]
        }
        
        return ""
    }
    /**
      去掉左右空格
     */
    func trimmed () -> String {
        return trimmedLeft().trimmedRight()
    }
    
    /**
     string 转 CGFloat
     
     - returns: CGFloat
     */
    func toCGFloat()->CGFloat{
        
        return CGFloat((self as NSString).floatValue)
    }
    
    /**
      转换为Data
     */
    func toDate(_ format : String? = "yyyy-MM-dd") -> Date? {
        let text = self.trimmed().lowercased()
        let dateFmt = DateFormatter()
        dateFmt.timeZone = TimeZone.current
        if let fmt = format {
            dateFmt.dateFormat = fmt
        }
        return dateFmt.date(from: text)
    }
    
    /**
     转换为DataTime
     */
    func toDateTime(_ format : String? = "yyyy-MM-dd hh-mm-ss") -> Date? {
        return toDate(format)
    }
    
    /**
     转换成Double类型
     */
    func toDouble() -> Double? {
        let scanner = Scanner(string: self)
        var double: Double = 0
        
        if scanner.scanDouble(&double) {
            return double
        }
        return nil
    }
    /**
     转换成Float类型
     */
    func toFloat() -> Float? {
        let scanner = Scanner(string: self)
        var float: Float = 0
        
        if scanner.scanFloat(&float) {
            return float
        }
        return nil
    }
    
    /**
     转换成Int类型
     */
    func toInt() -> Int? {
        if let val = Int(self.trimmed()) {
            return Int(val)
        }
        return nil
    }
    
    /**
     转换成UInt类型
     */
    func toUInt() -> UInt? {
        if let val = Int(self.trimmed()) {
            if val < 0 {
                return nil
            }
            return UInt(val)
        }
        return nil
    }
    
    /**
     转换成Bool类型
     */
    func toBool() -> Bool? {
        let text = self.trimmed().lowercased()
        if text == "true" || text == "false" || text == "yes" || text == "no" {
            return (text as NSString).boolValue
        }
        return nil
    }
    
    /**
      插入字符串
     */
    func insert (_ index: Int, _ string: String) -> String {
        if index > length {
            return self + string
        } else if index < 0 {
            return string + self
        }
        return self[0..<index]! + string + self[index..<length]!
    }
    
    /**
      根据Range取字符
     */
    subscript (range: Range<Int>) -> String? {
        if range.lowerBound < 0 || range.upperBound > self.length {
            return nil
        }
        let range = (characters.index(startIndex, offsetBy: range.lowerBound) ..< characters.index(startIndex, offsetBy: range.upperBound))
        return self[range]
    }

    
    /// 返回本地化后的string
    var localized: String {
        let s = NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
        return s
    }
    
    /**
     返回短日期string
     */
    func shortDataString()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self) else {
            return self
        }
        dateFormatter.dateFormat = "MM月dd日"
        let str = dateFormatter.string(from: date)
        return str
    }
    
    func toAttr()->NSMutableAttributedString{
        return NSMutableAttributedString(string: self)
    }
    
    //escape编码
    func escape()->String{
        return OCTool.escape(self)!
    }
    //unescape解码
    func unescape()->String{
        return OCTool.unescape(self)!
    }
    
}
