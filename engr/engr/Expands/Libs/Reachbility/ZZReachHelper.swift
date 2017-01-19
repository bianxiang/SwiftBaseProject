//
//  ZZReachHelper.swift
//  zuber
//
//  Created by duzhe on 16/1/17.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import UIKit

class ZZReachHelper: NSObject {
    
    /**
     wifi是否可用
     */
    static func isEnableWIFI()->Bool{
        return Reachability.forLocalWiFi().isReachableViaWiFi()
    }
    
    /**
     流量是否可用
     */
    static func isEnable4G()->Bool{
        return Reachability.forInternetConnection().currentReachabilityStatus() != .NotReachable
    }
    
    /**
     是否可以连接zuber的后台
     */
    static func isEnableZuber()->Bool{
        let reach = Reachability(hostName: "http://www.zuber.im")
        return reach!.currentReachabilityStatus() != .NotReachable
    }
    
    /**
     网络是否正常 并且可连接zuber
     */
    static func isEnableNet()->Bool{
        return  (isEnable4G() || isEnableWIFI())
    }
}
