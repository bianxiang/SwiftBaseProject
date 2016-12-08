//
//  UIScrollView+Add.swift
//  zuber
//
//  Created by duzhe on 16/1/5.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import UIKit

extension UIScrollView{
    
    //滚动到底部
    func scrollToBottom(animation:Bool) {
        let visibleBottomRect = CGRect(x: 0, y: contentSize.height-bounds.size.height, width: 1, height: bounds.size.height)
        UIView.animate(withDuration: animation ? 0.2 : 0.01, animations: { () -> Void in
            self.scrollRectToVisible(visibleBottomRect, animated: true)
        }) 
    }
    
}

