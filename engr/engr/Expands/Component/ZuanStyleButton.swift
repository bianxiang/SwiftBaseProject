//
//  ZuanStyleButton.swift
//  FindWork
//
//  Created by 1234 on 2016/12/6.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import UIKit
//enum ZuanStyle {
//    case normal
//    case huncai
//    case huncaidingwei
//}
class ZuanStyleButton: UIButton {
    var previousBtn : ZuanStyleButton?
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 2.0
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.REMIND_COLOR.cgColor
        self.layer.borderWidth = 1
        
        self.setTitleColor(UIColor.REMIND_COLOR, for: .normal)
        self.setTitleColor(UIColor.white, for: .selected)
        
        
        
    }
    

}
