//
//  AppDelegate+Login.swift
//  FindWork
//
//  Created by duzhe on 2016/10/21.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import PKHUD

protocol AuthorDelegate:NSObjectProtocol{
    func loginAuthorSuccess(user: User?)
}
protocol WXShareDelegate:NSObjectProtocol{
    func wxShareCompleted(resp: SendMessageToWXResp?)
}
protocol WXPayDelegate:NSObjectProtocol {
    func wxPayCompleted(resp: PayResp?)
}

extension AppDelegate:WXApiDelegate{
//    var _mapManager: BMKMapManager?
    //第三方注册此app
    func registerApp(_ launchOptions: [UIApplicationLaunchOptionsKey: Any]?){
//        // 如果要关注网络及授权验证事件，请设定generalDelegate参数
//        let ret = _mapManager?.start("cpuGtN9NOSGULulrz1zfYTN5svGC8kEt", generalDelegate: nil)
//        if ret == false {
//            zp("百度地图启动失败manager start failed!")
//        }else {
//            zp("百度地图启动成功")
//        }
        
        
        //微信
        WXApi.registerApp(kWxAppkey)
        //qq
        _ = TencentOAuth(appId: kQQ_appId, andDelegate: nil)
        //GrowingIO
//        Growing.start(withAccountId: kGrowingIO_appID)
        
        //Bugly
        Bugly.start(withAppId: kBugly_appId)
        
    }
    
    @objc(application:handleOpenURL:) func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        if url.absoluteString.hasPrefix(kWxAppkey){
            return WXApi.handleOpen(url, delegate: self)
        }
        else if url.scheme == kQQurlscheme
        {
            return TencentOAuth.handleOpen(url)
        }
            
        else if url.absoluteString.hasPrefix("tmpWorkAliPay://safepay/"){
            alipay(url)
            return true
        }
//        else if Growing.handle(url){
//            return true
//        }
        
        
        else{
            return false
        }
    }
   
    @objc(application:openURL:sourceApplication:annotation:) func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if url.absoluteString.hasPrefix(kWxAppkey){
            return WXApi.handleOpen(url, delegate: self)
        }
        else if url.scheme == kQQurlscheme
        {
            return TencentOAuth.handleOpen(url)
        }
        
        else if url.absoluteString.hasPrefix("tmpWorkAliPay://safepay/"){
            alipay(url)
            return true
        }
//        else if Growing.handle(url){
//            return true
//        }
            
        else{
            return false
        }
    }
    
    func onReq(_ req: BaseReq!) {
        zp(req)
    }
    
    
    
    func onResp(_ resp: BaseResp!) {
        zp(resp.errStr)
        if let resp = resp as? SendAuthResp{
            //登录相关回调
            if let _ = resp.code{
                if let code = resp.code {
                    let params:Parameters = ["type":1,"mobile":"","wxCode":code,"idCode":""]
                    // 登录
                    HUD.show(HUDContentType.progress)
                    LoginViewModel.shared.wxLogin(params: params, complete: { (result) in
                        HUD.hide(animated: true)
                        result.resSuccess({ (user) in
                            // 存本地数据
                            _g.user = user
                            self.authorDelegate?.loginAuthorSuccess(user: user)
                        })
                    })
                }
            }
        }
        //MARK: - 微信分享回调
        else if let resp = resp as? SendMessageToWXResp{
            zp(resp.errCode)
            zp(resp.errStr)
            self.wxShareDelegate?.wxShareCompleted(resp: resp)
        }
        //MARK: - 微信支付回调
        else if let resp = resp as? PayResp{
            zp(resp.errCode)
            zp(resp.errStr)
            self.wxPayDelegate?.wxPayCompleted(resp: resp)
        }
        
    }
    
    /**
     获取当前显示在最前端的vc
     
     - returns: vc
     */
    func activityViewController() -> UIViewController?{
        let vc = self.mainVC?.selectedViewController
        if  let navVC = vc as? UINavigationController{
            return navVC.visibleViewController
        }else{
            return vc
        }
    }
    
    
    /**
     支付结果
     
     - parameter url: safepay
     */
    func alipay(_ url: URL){
        // 跳转支付钱包进行支付，处理支付结果
        //            9000	订单支付成功
        //            8000	正在处理中
        //            4000	订单支付失败
        //            6001	用户中途取消
        //            6002	网络连接出错
//        AlipaySDK.defaultService().processOrder(withPaymentResult: url, standbyCallback: { [weak self] (resultDic) in
//            guard let strongSelf = self else { return }
//            print("222-> \(resultDic?["resultStatus"])----------\(resultDic?["result"])")
//            strongSelf.rechargeDelegate?.rechargeComplete(resultDic!)
//        })
    }

    
}


