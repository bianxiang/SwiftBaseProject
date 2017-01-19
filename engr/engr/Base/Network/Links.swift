//
//  Links.swift
//  zuber
//
//  Created by duzhe on 15/12/7.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import Foundation

enum Links{
    
    case login  // 登录
    case sendIdCode(type:Int,phone:String) // 手机验证码
    case queryTw // 零活首页查询
    case findMetadata(version:String) // 查询元数据 默认 "0.0"
    case getTw // 详情页
    case bind   // 绑定手机号或者角色
    case upload // 上传
    case getOftenAdr // 获取常用地址
    case makeOftenAdr // 新增和修改常用地址
    case findOftenAdr // 查询常用地址列表
    case publish // 发布
    case deleteOftenAdr // 删除常用地址
    case getUserInfo // 获取用户详情
    case orderTw    // 抢单
    case pay    // 支付
    case charge // 充值
    case appraise // 评价和更新评价
    case operateTw // 用户零活行为 ,action参数为collect时表示收藏
    case queryMyTw // 查询我的单
    case toPay // 用于待支付页面的支付功能
    case count // 浏览次数
    case underTw // 上下架
    case queryMypurse // 钱包
    
    //////////////////////////////
    /////////////我的//////////////
    //////////////////////////////
    case updateUserInfo
    case queryShareRecord
    case advise
    case queryMsg
    
    // 基础api连接
    var baseUrl:String {
//        return "http://192.168.10.180:8982/gateway/api"
        return "https://twg.lovedabai.com/gateway/api"
    }
    
    //连接
    var url:String{
        switch self{
        case .login:
            return "\(baseUrl)/login"
        case .sendIdCode(let type,let phone):
            return "\(baseUrl)/sendIdCode/\(type)/\(phone)"
        case .queryTw:
            return "\(baseUrl)/queryTw"
        case .findMetadata(let version):
            return "\(baseUrl)/findMetadata/\(version)"
        case .getTw:
            return "\(baseUrl)/getTw"
        case .bind:
            return "\(baseUrl)/bind"
        case .upload:
            return "\(baseUrl)/upload"
        case .getOftenAdr:
            return "\(baseUrl)/getOftenAdr"
        case .makeOftenAdr:
            return "\(baseUrl)/makeOftenAdr"
        case .findOftenAdr:
            return "\(baseUrl)/findOftenAdr"
        case .publish:
            return "\(baseUrl)/publish"
        case .deleteOftenAdr:
            return "\(baseUrl)/deleteOftenAdr"
        case .getUserInfo:
            return "\(baseUrl)/getUserInfo"
        case .orderTw:
            return "\(baseUrl)/orderTw"
        case .pay:
            return "\(baseUrl)/pay"
        case .charge:
            return "\(baseUrl)/charge"
        case .appraise:
            return "\(baseUrl)/appraise"
        case .operateTw:
            return "\(baseUrl)/operateTw"
        case .queryMyTw:
            return "\(baseUrl)/queryMyTw"
        case .toPay:
            return "\(baseUrl)/toPay"
        case .count:
            return "\(baseUrl)/count"
        case .updateUserInfo:
            return "\(baseUrl)/updateUserInfo"
        case .queryMypurse:
            return "\(baseUrl)/queryMypurse"
            
        case .underTw:
            return "\(baseUrl)/underTw"
        case .queryShareRecord:
            return "\(baseUrl)/queryShareRecord"
        case .advise:
            return "\(baseUrl)/advise"
        case .queryMsg:
            return "\(baseUrl)/queryMsg"
        
        }
        
    }
    

}
