//
//  UILabel+Add.swift
//  zuber
//
//  Created by duzhe on 15/12/8.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit


extension UILabel{
    
    func we17(){
        self.textAlignment = .left
        self.textColor = UIColor.white
        self.numberOfLines = 0
        self.font = UIFont.systemFont(ofSize: 15)
    }
    
    func we18(){
        self.textAlignment = .left
        self.textColor = UIColor.white
        self.numberOfLines = 1
        self.font = UIFont.systemFont(ofSize: 18)
    }
    
    
    func we15(){
        self.textAlignment = .left
        self.textColor = UIColor.white
        self.numberOfLines = 0
        self.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    //白色 15号字
    func w15(){
        self.textAlignment = NSTextAlignment.center
        self.textColor = UIColor.white
        self.numberOfLines = 0
        self.font = UIFont.systemFont(ofSize: 15)
    }
    func w14(){
        self.textAlignment = NSTextAlignment.center
        self.textColor = UIColor.white
        self.numberOfLines = 1
        self.font = UIFont.systemFont(ofSize: 14)
    }
    
    
    func w10(){
        self.textAlignment = NSTextAlignment.center
        self.textColor = UIColor.white
        self.numberOfLines = 1
        self.font = UIFont.systemFont(ofSize: 10)
    }
    
    
    func w13(){
        self.textAlignment = NSTextAlignment.center
        self.textColor = UIColor.white
        self.numberOfLines = 0
        self.font = UIFont.boldSystemFont(ofSize: 13) 
    }
    
    func w12(){
        self.textAlignment = NSTextAlignment.center
        self.textColor = UIColor.white
        self.numberOfLines = 0
        self.font = UIFont.systemFont(ofSize: 12)
    }
    
    func cellFont(){
        self.textColor = UIColor.TEXT_COLOR
        self.font = UIFont.systemFont(ofSize: 16)
    }
    
    func b13(){
        self.textColor = UIColor.REMIND_COLOR
        self.font = UIFont.systemFont(ofSize: 13)
    }
    
    func textWithLineSpace(_ txt:String){
        let attrString = NSMutableAttributedString(string: txt)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
//        attrString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, txt.characters.count))
        attrString.addAttributes([NSParagraphStyleAttributeName:style,
            NSForegroundColorAttributeName:UIColor.TEXT_COLOR], range: NSMakeRange(0, txt.characters.count))
        self.attributedText = attrString
    }
}
