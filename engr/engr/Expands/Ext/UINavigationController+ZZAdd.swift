//
//  UINavigationController+ZZAdd.swift
//  zuber
//
//  Created by duzhe on 16/6/17.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import UIKit


extension UINavigationController{
    
    /**
     移除vc
     
     - parameter vc: vc
     */
    func removeViewController(_ outvc:UIViewController){
        var i = 0
        for vc in self.viewControllers{
            if vc == outvc{
                self.viewControllers.remove(at: i)
            }
            i += 1
        }
    }
    
}

