//
//  ZZCacheHelper.swift
//  zuber
//
//  Created by duzhe on 15/12/7.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import Foundation

class ZZCacheHelper {
    
    static func save(_ key:String,value:Any?){
        ZZCacheManager.sharedManager.saveModelToFile(key, value: value)
    }
    
    static func get(_ key:String)->Any?{
        return ZZCacheManager.sharedManager.getInfoFromDisk(key)
    }
}
