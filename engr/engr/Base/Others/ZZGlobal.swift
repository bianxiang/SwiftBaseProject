//
//  ZZGlobal.swift
//  FindWork
//
//  Created by duzhe on 2016/10/25.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import Foundation

typealias _g = ZZGlobal

struct ZZGlobal {
    
    static var latitude :Double?
    static var longitude :Double?
    
    static let pageSize = 10
//    static var metadata:Metadata?
    static var user:User?
    static var token:String {
        return $.nvl(ZZGlobal.user?.token ?? $.nvl(ZZGlobal.user?.tempToken))
    }
    static var userIdentifer:UserIdentifer {
        if $.nvl(ZZGlobal.user?.userRole) == "boss" {
            return .boss
        }else if $.nvl(ZZGlobal.user?.userRole) == "worker"{
            return .worker
        }else {
            return .none
        }
    }
    static var cityId:Int = 1 // 为首页查询
    static var marketId:Int = 0 // 市场
    static var startTime:String = Utils.timeStamp()
    static var sort:Int = 0  //  1 价格从高到低  2离我最经
    static let uniteDic:[String:String] = ["yuan":"元","jiao":"角","fen":"分","li":"厘"]
    static let countDic:[String:String] = ["hour":"小时","item":"件","ke":"颗钻"]
    static let filterTimes:[String] = ["全部零工","今日零工","明日零工"]
    static let filterSort:[String] = ["最新发布","价格最高","离我最近"]
}
