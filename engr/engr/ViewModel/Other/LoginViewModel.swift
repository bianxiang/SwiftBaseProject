//
//  LoginViewModel.swift
//  FindWork
//
//  Created by duzhe on 2016/10/26.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import Foundation
import PKHUD
let testPhones = ["15216629448",
                  "15216629445",
                  "15216629447",
                  "15216629449",
                  "14757882150",
                  "18368386903",//小仙女
                  "18969855329",//熊猫
                  "15216629441",
                  "15216629400",
                  "18612205027",
                  "13524414730"//小仙女2
]
struct LoginViewModel {
    
    /// 单例对象
    static let shared:LoginViewModel = LoginViewModel()
    
    init() {
        
    }
    
    /// 发送手机验证码
    func sendIdCode(_ type:Int = 0 , phone:String){
        _$.req(link: Links.sendIdCode(type: type, phone: phone) , parameters: nil) { (json) in
            
            if testPhones.contains(phone) {
                
                HUD.flash(HUDContentType.labeledSuccess(title: json["result"].stringValue, subtitle: nil), delay: 1)
            }
            
        }
    }
    
    /// 手机号码登录
    func loginWithPhone(mobile:String,idCode:String,complete:@escaping ((_ result:ZZResult<User>) -> ())){
        let params:[String:Any] = ["type":"0" , "mobile":mobile , "wxCode":"","idCode":idCode]
        _$.req(link: Links.login , parameters: params) { (json) in
            zp(json)
            let obj = json["result"].object
            if let user = ZZMap<User>.fromJson(obj){
                complete(.success(user))
                
                ZZGlobal.user = user
                // 存document目录 
                ZZCacheHelper.save("\(__$.login_user_key)_\(user.id)" , value: user)
                // 存储key
                setDefault(__$.current_login_user, value: "\(__$.login_user_key)_\(user.id)")
                // 存储上次登录的手机号码
                setDefault(__$.last_user_phone, value: "\(user.mobile!)")
            }else{
                complete(.failure(.nilBack))
            }
        }
    }
    
    
    func wxLogin(params:[String:Any],complete:@escaping ((_ result:ZZResult<User>) -> ())){
        _$.req(link: Links.login , parameters: params) { (json) in
            
            let obj = json["result"].object
            if let user = ZZMap<User>.fromJson(obj){
                complete(.success(user))
                ZZGlobal.user = user
                // 存document目录
                ZZCacheHelper.save("\(__$.login_user_key)_\(user.id)" , value: user)
                // 存储key
                setDefault(__$.current_login_user, value: "\(__$.login_user_key)_\(user.id)")
            }else{
                complete(.failure(.nilBack))
            }
        }
    }
    
    func loadFromDisk(){
        if let key = getDefault(__$.current_login_user) as? String {
            if let user = ZZCacheHelper.get(key) as? User{
                ZZGlobal.user = user
                zp("头像url:" + user.thumbUrl)
                if ZZGlobal.user?.token != nil {
                    MeViewModel.shared.getUserInfo(complete: { (result) in
                        // 每次进来查一次
                        result.resSuccess({ (user) in
                            ZZGlobal.user = user
                        })
                    })
                }
                
            }
        }
    }
    
    
    /// 绑定角色
    func bindRole(token:String,role:String,complete:@escaping (()->())){
        let params:[String:Any] = ["token":token,"mobile":"","role":role,"code":""]
        _$.req(link: Links.bind , parameters: params) { (json) in
            let obj = json["result"].object
            if let user = ZZMap<User>.fromJson(obj){
                
                ZZGlobal.user = user
                // 存document目录
                ZZCacheHelper.save("\(__$.login_user_key)_\(user.id)" , value: user)
                // 存储key
                setDefault(__$.current_login_user, value: "\(__$.login_user_key)_\(user.id)")
            }
            complete()
        }
    }
    
    // 绑定手机
    func bindPhone(mobile:String,code:String,complete:@escaping ((_ result:ZZResult<User>) -> ())){
        let params:[String:Any] = ["token":_g.token,"mobile":mobile,"role":"","code":code]
        _$.req(link: Links.bind , parameters: params) { (json) in
            let obj = json["result"].object
            if let user = ZZMap<User>.fromJson(obj){
                complete(.success(user))
                ZZGlobal.user = user
                // 存document目录
                ZZCacheHelper.save("\(__$.login_user_key)_\(user.id)" , value: user)
                // 存储key
                setDefault(__$.current_login_user, value: "\(__$.login_user_key)_\(user.id)")
            }
        }
    }
    
    
}
