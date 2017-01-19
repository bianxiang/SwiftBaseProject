//
//  TabBarItemExt.swift
//  zuber
//
//  Created by duzhe on 15/11/22.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit
let  TabbarItemNums:Float = 3.0
let kMessageBadage = 889

extension UITabBar{
    
    func showBadgeOnItemIndex(_ index:Float){
        self.hideBadgeOnItemIndex(Int(index))
        
        let badgeView = UIView()
        badgeView.tag = 888+Int(index)
        badgeView.layer.cornerRadius = 4
        badgeView.backgroundColor = UIColor.red
        let tabFram = self.frame
        
        let percentX = (index + 0.6)/TabbarItemNums
        let x = ceilf(percentX * Float(tabFram.size.width))
        let y = ceilf(0.1 * Float(tabFram.size.height))
        badgeView.frame = CGRect(x: CGFloat(x), y: CGFloat(y), width: 8, height: 8)
        self.addSubview(badgeView)
        self.bringSubview(toFront: badgeView)
    }
    
    func hideBadgeOnItemIndex(_ index:Int){
        let items = self.subviews.filter{$0.tag == 888+index}
        if items.count > 0{
            items[0].removeFromSuperview()
        }
    }
}
