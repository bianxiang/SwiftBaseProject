//
//  BaseNet.swift
//  FindWork
//
//  Created by duzhe on 2016/10/21.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import PKHUD

class BaseNet{
    
    /// 单例对象
    static let shared:BaseNet = BaseNet()
    
    private init(){}
    
    @discardableResult
    func baseRequest(link:Links,parameters:Parameters?,success:((_ json:JSON)->())?,exception:((_ json:JSON)->())?) -> URLSessionTask? {
        zp("请求URL:\(link.url) 的参数 :==>\n \(JSON(parameters ?? [:]))",isShowDetail:false)

     
        
//        let p = ParamDES.des(param:parameters)
        
//       zp(JSON(parameters).description)
       let req = request(link.url, method: HTTPMethod.post , parameters: parameters , encoding: JSONEncoding.default , headers: nil ).validate().responseJSON { (response) in
        
            switch response.result{
            case .success(let v):
                let json = JSON(v)
                zp("请求URL:\(link.url) 的返回 :==>\n \(json)",isShowDetail:false)
                if let n = json["code"].int{
                    if n == 0 {
                        //成功
                        success?(json)
                    }else{
                        //异常
                        exception?(json)
                        zp(json)
                    }
                }
            case .failure(let err):
                // 失败
                HUD.flash(HUDContentType.label("网速不给力，请稍后再试!") , delay: 3)
                zp(err.localizedDescription)
                
                break
            }
        }
        
        return req.task
    }
    
    
    @discardableResult
    func requestSuccess(link:Links,parameters:Parameters?,success:((_ json:JSON)->())?,other:((_ code:Int,_ json:JSON)->())? = nil) -> URLSessionTask?{
        return baseRequest(link: link, parameters: parameters, success: success) { (json) in
            HUD.hide(animated: true)
            if let n = json["code"].int{
                if n == 1001 {
                    // 1001 找不到用户 
                    // 退出
                    HUD.flash(HUDContentType.label("登录失效，请重新登录"), delay: 2)
                    $.loginOut()
                }else if n == 1008 || n == 1009 {
                    // 支付
                    other?(n,json)
                }else{
                    if let msg = json["msg"].string{
                        zp(msg)
                        HUD.flash(HUDContentType.label(msg), delay: 3)
                    }
                }
            }
        }
    }
//    q(query)	是	无	上地、天安、中关、shanghai	输入建议关键字（支持拼音）
//    region	是	无	全国、北京市、131、江苏省等	所属城市/区域名称或代号
//    location	否	无	40.047857537164,116.31353434477	传入location参数后，返回结果将以距离进行排序
//    output	否	xml	json、xml	返回数据格式，可选json、xml两种
//    ak	是	无	E4805d16520de693a3fe707cdc962045	开发者访问密钥，必选。
//    sn	否	无		用户的权限签名
//    timestamp	否	无		设置sn后该值必选
    func reqForBaiduMap(query:String,region:String = "义乌",success:((_ json:JSON)->())?,exception:((_ json:JSON)->())? = nil) -> URLSessionTask? {
        let baseApi = "http://api.map.baidu.com/place/v2/suggestion"
        let params:Parameters = [ "query":query,"region":region , "output":"json" , "ak": __$.baidu_ak,"city_limit":"true"]
        zp(params)
        let req = request(baseApi, method: HTTPMethod.get , parameters: params, encoding: URLEncoding.default , headers: nil).validate().responseJSON { (response) in
        
            switch response.result{
            case .success(let v):
                zp(response.request)
                
                let json = JSON(v)
                if let n = json["status"].int{
                    if n == 0 {
                        //成功
                        success?(json)
                    }else{
                        //异常
                        exception?(json)
                    }
                }
                zp(json)
            case .failure(let err):
                zp(err.localizedDescription)
                // 失败
                break
            }
        }
        return req.task
    }
    
    
    func uploadMedia(link:Links,data:Data? , url:URL? ,success:((_ json:JSON)->())? ,exception:((_ json:JSON)->())?,task:((_ session:URLSessionTask?)->Void)? , uploadProgress:((_ progress:Double)->())? = nil ){
        zp(data)
        
        upload(multipartFormData: { (multipartFormData) in
            if let url = url{
                multipartFormData.append(url, withName: "files")
            }else if let data = data {
                multipartFormData.append(data, withName: "files")
            }
            
            }, to: link.url) { (encodingResult) in
                
                switch encodingResult{
                case .success(request: let upload, _, streamFileURL: _):
                    upload.uploadProgress(closure: { (progress) in
                        zp("上传进度：\(progress.fractionCompleted)")
                        uploadProgress?(progress.fractionCompleted)
                    })
                    let req = upload.responseJSON(completionHandler: { (response) in
                        
                        switch response.result{
                        case .success(let v):
                            let json = JSON(v)
                            if let n = json["code"].int{
                                if n == 0 {
                                    //成功
                                    success?(json)
                                }else{
                                    //异常
                                    exception?(json)
                                }
                            }
                            zp(json)
                        case .failure(let err):
                            // 失败
                            zp(err.localizedDescription)
                            break
                        }
                    })
                    // 把任务返回
                    task?(req.task)
                case .failure(let err):
                    zp(err.localizedDescription)
                    
                }
        }
        
    }
    
}



struct _$ {
    
    @discardableResult
    static func req(link:Links,parameters:Parameters?,other:((_ code:Int,_ json:JSON)->())? = nil,success:((_ json:JSON)->())?) -> URLSessionTask?{
        return BaseNet.shared.requestSuccess(link: link, parameters: parameters, success: success,other:other)
    }
    
    @discardableResult
    static func upload(link:Links,data:Data? , url:URL?,success:((_ json:JSON)->())?,exception:((_ json:JSON)->())? = nil , task:((_ session:URLSessionTask?)->Void)? = nil, uploadProgress:((_ progress:Double)->())? = nil ){
        return BaseNet.shared.uploadMedia(link: link, data: data,url:url, success: success, exception: exception, task:task,uploadProgress:uploadProgress)
    }
    
    @discardableResult
    static func reqForMap(query:String,region:String = "义乌",success:((_ json:JSON)->())?,exception:((_ json:JSON)->())? = nil) -> URLSessionTask? {
        return BaseNet.shared.reqForBaiduMap(query: query, region: region, success: success, exception: exception)
    }
    
}




