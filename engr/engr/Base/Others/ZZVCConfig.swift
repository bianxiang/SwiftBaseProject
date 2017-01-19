//
//  ZZVCConfig.swift
//  zuber
//
//  Created by duzhe on 16/6/1.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import UIKit

protocol VCConfig {
}
extension VCConfig where Self:UIViewController {
    /**
      黑色状态栏对应 nav bar不透明
     */
    func blackNavBar(){
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.black]
    }
    
    /**
     白色状态栏对应 nav bar透明
     */
    func whiteNavBar(){
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black  //白色
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default )
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    func whiteStatusBar(){
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black  //白色
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }
}


typealias Task = (_ cancel : Bool) -> ()
protocol ZZTask {
    
}

extension ZZTask{
    
    
    @discardableResult
    func delay(_ time:TimeInterval, task: @escaping ()->()) ->  Task? {
        func dispatch_later(_ block: (()->())?) {
            DispatchQueue.main.asyncAfter(
                deadline: DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC),
                execute: block!)
        }
        var result: Task?
        
        let delayedClosure: Task = {
            cancel in
            if (cancel == false) {
                DispatchQueue.main.async(execute: task)
            }
            result = nil
        }
        
        result = delayedClosure
        dispatch_later {
            if let delayedClosure = result {
                delayedClosure(false)
            }
        }
        
        return result;
    }
    
    func cancel(_ task:Task?) {
        task?(true)
    }

}




