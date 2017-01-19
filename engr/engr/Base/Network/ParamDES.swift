//
//  ParamDES.swift
//  FindWork
//
//  Created by 1234 on 2016/11/28.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
class ParamDES: NSObject {
    
    static func des(param:Parameters?) -> Parameters? {
        if param == nil {
            return nil
        }else {
//            zp("DES加密前:" + $.nvl(JSON(param).description))
            let DESString = OCTool.encryptUseDES($.nvl(JSON(param).description), key: "tW0k2!yw")
//            zp("DES加密后:" + DESString!)
            return ["encParams":DESString!]
        }
        
        
    }
}
