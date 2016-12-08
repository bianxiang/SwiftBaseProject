//
//  ZZConfig.swift
//  zuber
//
//  Created by duzhe on 16/8/5.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import Foundation

struct ZZConfig {
    
    var base_url_beta:String = ""
    var base_url:String = ""
    var base_sokect_beta:String = ""
    var base_sokect:String = ""
    
    static let shareManager = ZZConfig()
    
    init(){
        if let plistPath =  Bundle.main.path(forResource: "config" , ofType: "plist"){
            if let data = NSMutableDictionary(contentsOfFile: plistPath){
                if let base_url_beta = data["base_url_beta"] as? String{
                    self.base_url_beta = base_url_beta
                }
                if let base_url = data["base_url"] as? String{
                    self.base_url = base_url
                }
                if let base_sokect_beta = data["base_sokect_beta"] as? String{
                    self.base_sokect_beta = base_sokect_beta
                }
                if let base_sokect = data["base_sokect"] as? String{
                    self.base_sokect = base_sokect
                }
            }
        }
    }
    
    
}
