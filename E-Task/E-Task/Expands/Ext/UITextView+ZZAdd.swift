//
//  UITextView+Add.swift
//  zuber
//
//  Created by duzhe on 15/12/14.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import Foundation
import UIKit

extension UITextView{
    //MARK: - 行距 5 属性字
    func textWithLineSpace(_ txt:String){
        let attrString = NSMutableAttributedString(string: txt)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        attrString.addAttributes([NSParagraphStyleAttributeName:style,
            NSForegroundColorAttributeName:UIColor.TEXT_COLOR,
            NSFontAttributeName:UIFont.systemFont(ofSize: 15)], range: NSMakeRange(0,attrString.length))
        self.attributedText = attrString
    }
}
