//
//  WXHelper.swift
//  FindWork
//
//  Created by 1234 on 2016/11/11.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import UIKit

enum WXHelperShareScene {
    case session//回话
    case timeline//朋友圈
}
class WXHelper: NSObject,WXApiDelegate {
    static let shared = WXHelper()
    var result : ((_ isSuccess:Bool)->())?
    
    //分享链接到微信
    func shareLinkToWX(scene:WXHelperShareScene,title:String,previewImageURL:String,description:String,contentURL:String,result:((_ isSuccess:Bool)->())? = nil){
        AppD.wxShareDelegate = self
        //分享到微信-
        let msg = WXMediaMessage()
        msg.title = title
        msg.description = description
        let imgURL = URL(string:previewImageURL)
        var data = Data()
        do{
            if let u = imgURL {
                data = try Data(contentsOf:u)
            }
            
            
        }catch {
            zp("error")
        }
        
        
        let img = UIImage(data: data)
        
        msg.setThumbImage(img)
   
        let ext = WXWebpageObject()
        ext.webpageUrl = contentURL
        msg.mediaObject = ext
        let req = SendMessageToWXReq()
        req.bText = false
        req.message = msg
        if scene == .session {
            req.scene = Int32(WXSceneSession.rawValue)
            
        }else if scene == .timeline {
            req.scene = Int32(WXSceneTimeline.rawValue)
        }
        
        var b = WXApi.send(req)
        self.result = result
//        if result != nil {
//            result!(b)
//        }
        
    }
    
    
    
    
//    func wxPay(_ charges:ChargeOrders,result:((_ isSuccess:Bool)->())? = nil){
//        AppD.wxPayDelegate = self
//        var req = PayReq()
//        req.partnerId = charges.wxOrderInfo?.partnerId
//        req.prepayId = charges.wxOrderInfo?.prepayId
//        req.nonceStr = charges.wxOrderInfo?.nonceStr
//        
//        req.timeStamp = UInt32((charges.wxOrderInfo?.timeStamp)!)!
//        req.package = charges.wxOrderInfo?.packageValue
//        req.sign = charges.wxOrderInfo?.sign
//        
//        WXApi.send(req)
//        self.result = result
//        
//    }
}

//微信分享回调
extension WXHelper:WXShareDelegate {
    internal func wxShareCompleted(resp: SendMessageToWXResp?) {
        if resp?.errCode == 0 {
            self.result!(true)
        }else {
            self.result!(false)
        }
    }

}

//微信支付回调
extension WXHelper:WXPayDelegate {
    internal func wxPayCompleted(resp: PayResp?) {
        if resp?.errCode == 0 {
            self.result!(true)
        }else {
            self.result!(false)
        }
    }

    
}

