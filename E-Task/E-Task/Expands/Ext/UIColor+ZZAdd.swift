//
//  UIColor+Add.swift
//  zuber
//
//  Created by duzhe on 16/2/26.
//  Copyright © 2016年 duzhe. All rights reserved.
//
import UIKit

extension UIColor{
    
    convenience init?(hexString: String) {
        self.init(hexString: hexString, alpha: 1.0)
    }
    
    
    convenience init?(hexString: String, alpha: Float) {
        var hex = hexString
        
        if hex.hasPrefix("#") {
            hex = hex.substring(from: hex.characters.index(hex.startIndex, offsetBy: 1))
        }
        
        if let _ = hex.range(of: "(^[0-9A-Fa-f]{6}$)|(^[0-9A-Fa-f]{3}$)", options: .regularExpression) {
            if hex.lengthOfBytes(using: String.Encoding.utf8) == 3 {
                let redHex = hex.substring(to: hex.characters.index(hex.startIndex, offsetBy: 1))
                let greenHex = hex.substring(with: Range<String.Index>(hex.characters.index(hex.startIndex, offsetBy: 1) ..< hex.characters.index(hex.startIndex, offsetBy: 2)))
                let blueHex = hex.substring(from: hex.characters.index(hex.startIndex, offsetBy: 2))
                hex = redHex + redHex + greenHex + greenHex + blueHex + blueHex
            }
            
            let redHex = hex.substring(to: hex.characters.index(hex.startIndex, offsetBy: 2))
            let greenHex = hex.substring(with: Range<String.Index>(Range<String.Index>(hex.characters.index(hex.startIndex, offsetBy: 2) ..< hex.characters.index(hex.startIndex, offsetBy: 4))))
            let blueHex = hex.substring(with: Range<String.Index>(Range<String.Index>(hex.characters.index(hex.startIndex, offsetBy: 4) ..< hex.characters.index(hex.startIndex, offsetBy: 6))))
            var redInt:   CUnsignedInt = 0
            var greenInt: CUnsignedInt = 0
            var blueInt:  CUnsignedInt = 0
            
            Scanner(string: redHex).scanHexInt32(&redInt)
            Scanner(string: greenHex).scanHexInt32(&greenInt)
            Scanner(string: blueHex).scanHexInt32(&blueInt)
            
            self.init(red: CGFloat(redInt) / 255.0, green: CGFloat(greenInt) / 255.0, blue: CGFloat(blueInt) / 255.0, alpha: CGFloat(alpha))
        }
        else
        {
            self.init()
            return nil
        }
    }
    
    convenience init?(hex: Int) {
        self.init(hex: hex, alpha: 1.0)
    }
    
    
    convenience init?(hex: Int, alpha: Float) {
        let hexString = NSString(format: "%2X", hex)
        self.init(hexString: hexString as String, alpha: alpha)
    }
    
    //MARK: - 颜色常量
  
    // 主色17ABFF
    @nonobjc static let main = UIColor(red: 0x17/255.0, green: 0xab/255.0, blue:0xff/255.0, alpha: 1.0)
    // 标准背景色
    @nonobjc static let standard = UIColor(red: 0xF0/255.0, green: 0xF1/255.0, blue:0xF5/255.0, alpha: 1.0)
    @nonobjc static let starGrey = UIColor(red: 196/255.0, green: 196/255.0, blue:196/255.0, alpha: 1.0)
    @nonobjc static let dark = UIColor(red: 155/255.0, green: 155/255.0, blue:155/255.0, alpha: 1.0)
    
    
    // 边线颜色
    @nonobjc static let LINE_COLOR = UIColor(red: 231/255.0, green: 231/255.0, blue:231/255.0, alpha: 1.0)
    // 站字符颜色
    @nonobjc static let HODER_COLOR = UIColor(red: 0xCA/255.0, green: 0xCA/255.0, blue:0xCC/255.0, alpha: 1.0)
    
    // tag标签的颜色
    @nonobjc static let TAG_BORDER = UIColor(red: 0xAE/255.0, green: 0xAE/255.0, blue:0xAE/255.0, alpha: 1.0)
    // tag文本的颜色
    @nonobjc static let TAG_TEXT_COLOR = UIColor(red: 0x45/255.0, green: 0x45/255.0, blue:0x45/255.0, alpha: 1.0)
    // 明细页文本的颜色
    @nonobjc static let DETAIL_TEXT_COLOR = UIColor(red: 0xDE/255.0, green: 0xDF/255.0, blue:0xE0/255.0, alpha: 1.0)
    // 部分页面的文本颜色
    @nonobjc static let TEXT_COLOR = UIColor(red: 66/255.0, green: 66/255.0, blue: 66/255.0, alpha: 1.0)
    // 缺省页面的文本颜色
    @nonobjc static let QS_COLOR = UIColor(red: 163/255.0, green: 163/255.0, blue:163/255.0, alpha: 1.0)
    // 其他人发送信息的颜色
    @nonobjc static let OTHER_MESSAGE_COLOR = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1.0)
    
    @nonobjc static let REMIND_COLOR = UIColor(red: 0x99/255.0, green: 0x99/255.0, blue: 0x99/255.0, alpha: 1.0)
    @nonobjc static let BORDER_COLOR = UIColor(red: 0xDB/255.0, green: 0xDB/255.0, blue: 0xDB/255.0, alpha: 1.0)
    @nonobjc static let CONTENT_COLOR = UIColor(red: 0x4A/255.0, green: 0x4A/255.0, blue: 0x4A/255.0, alpha: 1.0)
    @nonobjc static let BLACK_COLOR = UIColor(red: 0x00/255.0, green: 0x00/255.0, blue: 0x00/255.0, alpha: 1.0)
    @nonobjc static let PUBLISH_TIP_COLOR = UIColor(red: 18/255.0, green: 131/255.0, blue: 110/255.0, alpha: 1.0)
    @nonobjc static let MONEY_REMIND_COLOR = UIColor(red: 0xFF/255.0, green: 0x5B/255.0, blue: 0x42/255.0, alpha: 1.0)
    @nonobjc static let LIGHT_GREY = UIColor(red: 249/255.0, green: 249/255.0, blue: 249/255.0, alpha: 1.0)
    @nonobjc static let MONEY_COLOR = UIColor(red: 0xFd/255.0, green: 0x56/255.0, blue: 0x43/255.0, alpha: 1.0)
    
    // 红包字体颜色黄色
    @nonobjc static let redbag = UIColor(red: 0xF8/255.0, green: 0xE7/255.0, blue: 0x1C/255.0, alpha: 1.0)
    // 红包红色
    @nonobjc static let redbagBgRed = UIColor(red: 0xFD/255.0, green: 0x56/255.0, blue: 0x32/255.0, alpha: 1.0)
    // 倒计时背景紫色
    @nonobjc static let countDownZise = UIColor(red: 0x9F/255.0, green: 0x80/255.0, blue: 0xFF/255.0, alpha: 1.0)
    
    
    
    
}
