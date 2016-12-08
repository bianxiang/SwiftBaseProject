//
//  ZZResult.swift
//  zuber
//
//  Created by duzhe on 16/6/4.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import Foundation
import PKHUD

enum ZZResult<T> {
    case success(T)
    case failure(ZZError)
}

extension ZZResult{
    func resSuccess (_ block:((T)->Void)){
        switch  self {
        case .success(let t):
            block(t)
        case .failure(let err):
            HUD.flash(.label(err.rawValue), delay: 0.8)
        }
    }
    
    func result(_ success:((T)->Void),fail:((String)->Void)){
        switch  self {
        case .success(let t):
            success(t)
        case .failure(let err):
            fail(err.rawValue)
        }
    }
    
    func map( _ transform: (T) throws -> T) -> ZZResult<T> {
        switch self {
        case .success(let object):
            do {
                let nextObject = try transform(object)
                return ZZResult<T>.success(nextObject)
            } catch {
                return ZZResult<T>.failure(.formatError)
            }
        case .failure(let error):
            return ZZResult<T>.failure(error)
        }
    }
}



enum ZZError:String {
    case serviceException = "服务器异常"
    case netException = "网络异常"
    case nilBack = "返回数据异常"
    case order_8000 = "订单正在处理中"
    case order_4000 = "订单支付失败"
    case order_6001 = "用户中途取消"
    case order_6002 = "网络连接出错"
    case formatError = "格式错误"
    case other = "未知错误"
}
