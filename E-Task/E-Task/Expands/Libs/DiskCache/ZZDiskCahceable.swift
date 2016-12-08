//
//  ZZDiskCahceable.swift
//  zuber
//
//  Created by duzhe on 16/6/16.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import Foundation


protocol ZZDiskCahceable {
    
    
    
}


extension ZZDiskCahceable{
    /**
     本地缓存对象
     */
    func saveObj(_ key:String,value:Any?,completeHandler:(()->())? = nil){
        
        ZZDiskCache.sharedCacheObj.stroe(key, value: value, image: nil, data: nil, completeHandler: completeHandler)
        
    }
    
    /**
     获得本地缓存的对象
     */
    func getObj(_ key:String,compelete:@escaping ((_ obj:Any?)->())){
        
        
        ZZDiskCache.sharedCacheObj.retrieve(key, objectGetHandler: compelete, imageGetHandler: nil, voiceGetHandler: nil)
        
    }
    
}
