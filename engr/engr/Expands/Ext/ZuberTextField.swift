//
//  UITextFieldExt.swift
//  zuber
//
//  Created by duzhe on 15/11/29.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class ZuberTextField:UITextField {
    
    override func textRect(forBounds bounds:CGRect)->CGRect{
        let inset = CGRect(x: bounds.origin.x+10, y: bounds.origin.y, width: bounds.size.width - 10, height: bounds.size.height);
        return inset;
    }
    
    override func editingRect(forBounds bounds:CGRect)->CGRect{
        let inset = CGRect(x: bounds.origin.x+10, y: bounds.origin.y, width: bounds.size.width - 10, height: bounds.size.height);
        return inset;
    }
    
    //MARK: -设置placeholder的颜色 字体
    override func drawPlaceholder(in rect:CGRect){
        if let hoder = self.placeholder{
            let first_attr = [NSFontAttributeName:UIFont.boldSystemFont(ofSize: 14),NSForegroundColorAttributeName:UIColor.white.withAlphaComponent(0.5)]
            (hoder as NSString).draw(in: rect, withAttributes: first_attr)
        }
    }
    
    //MARK: -placehoder 位置
    override func placeholderRect(forBounds bounds:CGRect)->CGRect{
        let inset = CGRect(x: bounds.origin.x+10,y: bounds.origin.y+(bounds.size.height-28)/2, width: bounds.size.width - 10, height: 14);
        return inset;
    }
    
}

class ZuberTextFieldForBind:UITextField {
    override func textRect(forBounds bounds:CGRect)->CGRect{
        let inset = CGRect(x: bounds.origin.x+10, y: bounds.origin.y, width: bounds.size.width - 10, height: bounds.size.height);
        return inset;
    }
    
    override func editingRect(forBounds bounds:CGRect)->CGRect{
        let inset = CGRect(x: bounds.origin.x+10, y: bounds.origin.y, width: bounds.size.width - 10, height: bounds.size.height);
        return inset;
    }
}


class ZuberTextFieldForYZM:UITextField {
    override func textRect(forBounds bounds:CGRect)->CGRect{
        let inset = CGRect(x: bounds.origin.x+10, y: bounds.origin.y, width: bounds.size.width - 10, height: bounds.size.height);
        return inset;
    }
    
    override func editingRect(forBounds bounds:CGRect)->CGRect{
        let inset = CGRect(x: bounds.origin.x+10, y: bounds.origin.y, width: bounds.size.width - 10, height: bounds.size.height);
        return inset;
    }
    
    override func drawPlaceholder(in rect:CGRect){
        if let hoder = self.placeholder{
            let first_attr = [NSFontAttributeName:UIFont.boldSystemFont(ofSize: 14),NSForegroundColorAttributeName:UIColor.white.withAlphaComponent(0.5)]
            (hoder as NSString).draw(in: rect, withAttributes: first_attr)
        }
    }
    
    //MARK: -placehoder 位置
    override func placeholderRect(forBounds bounds:CGRect)->CGRect{
        let inset = CGRect(x: bounds.origin.x+10, y: bounds.origin.y+12, width: bounds.size.width - 10, height: bounds.size.height);
        return inset;
    }
}


class ZZTextField:UITextField{
    
    override func textRect(forBounds bounds:CGRect)->CGRect{
        let inset = CGRect(x: bounds.origin.x+3, y: bounds.origin.y, width: bounds.size.width - 3, height: bounds.size.height);
        return inset;
    }
    override func editingRect(forBounds bounds:CGRect)->CGRect{
        let inset = CGRect(x: bounds.origin.x+3, y: bounds.origin.y, width: bounds.size.width - 3, height: bounds.size.height);
        return inset;
    }
}

