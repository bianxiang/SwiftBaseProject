//
//  NSMutableAttributedString+ZZAdd.swift
//  LearnYY
//
//  Created by duzhe on 16/3/9.
//  Copyright © 2016年 dz. All rights reserved.
//

import UIKit

struct AttrName {
    static let ForegroundColor = NSForegroundColorAttributeName
    static let Font = NSFontAttributeName
    static let UnderlineStyle = NSUnderlineStyleAttributeName
    
}

//typealias Attribute = NSMutableAttributedString -> NSMutableAttributedString

//infix operator >>> {
//    associativity left
//}

infix operator >>> : AT

precedencegroup AT {
    associativity: left
}

func >>> (attr1 : NSMutableAttributedString ,attr2 : NSMutableAttributedString ) -> NSMutableAttributedString{
    attr1.append(attr2)
    return attr1
}

//func >>> (attr1:Attribute , attr2 : Attribute) -> Attribute{
//    return { attr in
//        return attr1(attr2(attr))
//    }
//}
//
//typealias Attribute = NSMutableAttributedString -> NSMutableAttributedString
//
//func zz_foreColor(color:UIColor)->Attribute{
//    return { attr in
//        attr.addAttributes([NSForegroundColorAttributeName:color], range: attr.allRange())
//        return attr
//    }
//}
//
//func zz_font(font:UIFont)->Attribute{
//    return { attr in
//        attr.addAttributes([NSFontAttributeName:font], range: attr.allRange())
//        return attr
//    }
//}

extension NSMutableAttributedString{
    func allRange()->NSRange{
        return NSMakeRange(0,self.length)
    }
    
    func setFount(_ font:UIFont,range:NSRange){
        self.setAttribute(NSFontAttributeName, value: font, range: range)
    }
    
    func setColor(_ color:UIColor,range:NSRange){
        self.setAttribute(kCTForegroundColorAttributeName as String , value: color.cgColor, range:range)
        self.setAttribute(NSForegroundColorAttributeName, value: color, range: range)
    }
    
    func setAttribute(_ name:String?,value:AnyObject?,range:NSRange){
        guard let name = name else{ return }
        guard let value = value else{
            self.removeAttribute(name, range: range)
            return
        }
        self.addAttribute(name, value: value, range: range)
    }
    
    
    func zz_appendAttributeString(_ attr:NSAttributedString)->NSMutableAttributedString{
        self.append(attr)
        return self
    }
    
    func zz_appendAttributeStringWithAttrMaker(_ AttrMaker:(Void) -> NSMutableAttributedString)->NSMutableAttributedString{
        self.append(AttrMaker())
        return self
    }
    
    func zz_addAttribute(_ name:String,value:AnyObject)->NSMutableAttributedString{
        self.addAttribute(name, value: value, range: self.allRange())
        return self
    }

    func zz_addAttribute(_ name:String,value:AnyObject,range:NSRange)->NSMutableAttributedString{
        self.addAttribute(name, value: value, range: range)
        return self
    }
    func foreColor(_ color:UIColor)->NSMutableAttributedString{
        self.addAttributes([NSForegroundColorAttributeName:color], range: self.allRange())
        return self
    }
    
    func font(_ font:UIFont)->NSMutableAttributedString{
        self.addAttributes([NSFontAttributeName:font], range: self.allRange())
        return self
    }
    
    func underline(_ lineColor:UIColor)->NSMutableAttributedString{
        self.addAttributes([NSUnderlineStyleAttributeName:1,NSUnderlineColorAttributeName:lineColor], range: self.allRange())
        return self
    }
    
}
