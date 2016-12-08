//
//  UITextField+ZZAdd.swift
//  zuber
//
//  Created by duzhe on 16/7/25.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import UIKit

extension UITextField{
    
    func configAccessoryView(){
        let topView = UIToolbar(frame: CGRect(x: 0,y: 0,width: _sw,height: 40))
        let btnSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace , target: self, action: nil)
        let btn = UIButton()
        btn.addTarget(self, action: #selector(resignFirstResponder), for: UIControlEvents.touchUpInside)
        btn.normal_title = "完成"
        btn.normal_color = UIColor.main
        btn.frame = CGRect(x: 0, y: 0, width: 40, height: 60)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        let doneBtn = UIBarButtonItem(customView: btn)
        doneBtn.tintColor = UIColor.main
        
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace , target: self, action: nil)
        topView.items = [btnSpace,doneBtn,space]
        self.inputAccessoryView = topView
    }
    
    var zz_hoder:String? {
        set(v){
            self.attributedPlaceholder = $.nvl(v).toAttr().foreColor(UIColor.HODER_COLOR)
        }
        get{
            return self.attributedPlaceholder?.string
        }
    }
}
