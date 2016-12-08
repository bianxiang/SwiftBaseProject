//
//  MineViewModel.swift
//  FindWork
//
//  Created by 1234 on 2016/11/1.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import UIKit

class MeViewModel {
    /// 单例对象
    static let shared:MeViewModel = MeViewModel()
    
    // MARK: 获取我的信息 getUserInfo
    @discardableResult
    func getUserInfo(complete:@escaping ((_ result:ZZResult<User>) -> ()))-> URLSessionTask?{
        let token = ZZGlobal.user?.token
        return _$.req(link: Links.getUserInfo , parameters: ["token" : $.nvl(token)], success: { (json) in
            zp(json)
            let obj = json["result"].object
            if let user = ZZMap<User>.fromJson(obj) {
                complete(.success(user))
                ZZGlobal.user = user
                // 存document目录
                ZZCacheHelper.save("\(__$.login_user_key)_\(user.id)" , value: user)
                // 存储key
                setDefault(__$.current_login_user, value: "\(__$.login_user_key)_\(user.id)")
            }else{
                complete(.failure(.nilBack))
            }
        })
    }
}
