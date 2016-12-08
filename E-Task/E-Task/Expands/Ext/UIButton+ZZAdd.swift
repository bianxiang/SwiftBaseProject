//
//  UIButton+Add.swift
//  zuber
//
//  Created by duzhe on 16/3/25.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import UIKit

extension UIButton{

    var normal_title:String?{
        set(v){
            self.setTitle(v,for: UIControlState())
        }
        get{
            return self.titleLabel?.text
        }
    }
    
    var normal_image:UIImage?{
        set(v){
            self.setImage(v, for: UIControlState())
        }
        get{
            return self.imageView?.image
        }
    }
    
    var normal_color:UIColor?{
        set(v){
            self.setTitleColor(v, for: UIControlState())
        }
        get{
            return self.titleLabel?.textColor
        }
    }
    
    func setNormalImageWithTitle(_ title:String){
        self.setImage(UIImage(named: title), for: UIControlState())
    }
    
    func normalStyle(){
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        self.backgroundColor = UIColor.main
        self.normal_color = UIColor.white
    }
}
