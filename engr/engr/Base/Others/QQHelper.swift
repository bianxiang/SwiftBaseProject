//
//  QQHelper.swift
//  FindWork
//
//  Created by 1234 on 2016/11/11.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import UIKit

class QQHelper {
    static let shared = QQHelper()
    
    //分享链接到qq好友
    func shareLinkToQQ(title:String,previewImageURL:String,description:String,contentURL:String){
        
        let newsObj = QQApiNewsObject(url: URL(string: contentURL), title: title, description: description, previewImageURL: URL(string: previewImageURL), targetContentType: QQApiURLTargetTypeNews)
        let req = SendMessageToQQReq(content: newsObj)
        let sent = QQApiInterface.send(req)
        self.handleSendResult(sendResult: sent)
        
    }
    
    
    
    
    //结果
    func handleSendResult(sendResult:QQApiSendResultCode) {
        switch sendResult {
            case EQQAPIAPPNOTREGISTED:
                zp("App未注册")
            case EQQAPIMESSAGECONTENTINVALID,EQQAPIMESSAGECONTENTNULL,EQQAPIMESSAGETYPEINVALID:
                zp("发送参数错误")
            case EQQAPIQQNOTINSTALLED:
                ZZAlert.showAlert(AppWindow.rootViewController!, meg: "未安装手机QQ")
            case EQQAPIQQNOTSUPPORTAPI:
                zp("API接口不支持")
            case EQQAPISENDFAILD:
                ZZAlert.showAlert(AppWindow.rootViewController!, meg: "发送失败")
            case EQQAPIVERSIONNEEDUPDATE:
                ZZAlert.showAlert(AppWindow.rootViewController!, meg: "当前QQ版本太低，需要更新")
        default:
            break
        }
    }
}
