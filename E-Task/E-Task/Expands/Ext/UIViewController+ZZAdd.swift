//
//  UIViewController+Add.swift
//  zuber
//
//  Created by duzhe on 15/12/9.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func withoutAnimation(_ handler:(()->())){
        CATransaction.begin()
        CATransaction.setDisableActions(true) // 关闭动画
        handler() //无动画执行
        CATransaction.commit()
    }

}
