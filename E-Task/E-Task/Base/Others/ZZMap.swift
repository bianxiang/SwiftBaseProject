//
//  ZZMap.swift
//  zuber
//
//  Created by duzhe on 16/8/26.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import Foundation
import ObjectMapper

struct ZZMap<T:Mappable> {
    static func fromJson(_ value:Any?)->T?{
        guard let value =  value else { return nil }
        let mapper = Mapper<T>()
        return mapper.map(JSONObject: value)
    }
}
