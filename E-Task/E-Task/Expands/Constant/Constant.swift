//
//  Constant.swift
//  FindWork
//
//  Created by duzhe on 2016/10/12.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import Foundation
import UIKit

//一些常量
let _sw:CGFloat = UIScreen.main.bounds.size.width  //屏幕宽度
let _sh:CGFloat = UIScreen.main.bounds.size.height //屏幕高度
let AppWindow = UIApplication.shared.delegate!.window!!
let AppD = UIApplication.shared.delegate! as! AppDelegate

let kGrowingIO_appID = "b45a6c11c8455b6a"
let kWxAppkey = "wxfc7c78478e366560"
let kQQurlscheme = "tencent101360145"
let kQQ_appId = "101360145"
let kCantPos = "定位服务未开启"
let kPosMsg = "请在手机设置中开启定位服务，并允许zuber使用定位服务"
let kUUID = UIDevice.current.identifierForVendor!.uuidString

typealias __$ = ZZConstant

struct ZZConstant {
    
    // 标签的高度
    static let TAG_HEIGHT:CGFloat = 20.0
    // 等待时间
    static let WAITTING_SECONDS:TimeInterval = 1.5
    // 状态栏高度
    static let STATUS_BAR_HEIGHT:CGFloat = UIApplication.shared.statusBarFrame.height
    // 信息菜单高度
    static let MESSAGE_MENU_HEIGHT:CGFloat = 40.0
    // 精度
    static let kJD = 3.00
    // 版本
    static let version_default = "0.0"
    
    static let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    
    // 登录存储
    static let login_user_key = "find_work_login_user_key"
    
    static let current_login_user = "current_login_user"
    static let last_user_phone = "last_user_phone"
    
    // 百度地图AK
    static let baidu_ak = "4vgzGdw8nzUZRqccOyiuN6cnXmPjC9yq" //"cpuGtN9NOSGULulrz1zfYTN5svGC8kEt"
    
    static let price_key = "tmp.work.price.key"
    static let category_key = "tmp.work.category.key"
    
    
    static let shareDescription = "一起用“找零工”，像滴滴一样找零工，挣钱更简单"
    
}


//MARK: - 延时执行
func delay(_ seconds: Double, completion:@escaping ()->()) {
    let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: popTime) {
        completion()
    }
}

func setDefault(_ key:String,value:Any?){
    if value == nil{
        UserDefaults.standard.removeObject(forKey: key)
    }else{
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize() //同步
    }
}

func removeUserDefault(_ key:String?){
    if key != nil{
        UserDefaults.standard.removeObject(forKey: key!)
        UserDefaults.standard.synchronize()
    }
}

func getDefault(_ key:String) ->Any?{
    return UserDefaults.standard.value(forKey: key)
}

func decisionShowSize(_ imgSize: CGSize) ->CGSize{
    let heightRatio = imgSize.height / _sh
    let widthRatio = imgSize.width / _sw
    if heightRatio > 1 && widthRatio>1 {return imgSize.ratioSize(max(heightRatio, widthRatio))}
    if heightRatio > 1 && widthRatio <= 1 {return imgSize.ratioSize(heightRatio)}
    if heightRatio <= 1 && widthRatio > 1 {return imgSize.ratioSize(widthRatio)}
    if heightRatio <= 1 && widthRatio < 1 {return imgSize.ratioSize(max(widthRatio,heightRatio))}
    return imgSize
}

/**
 在debug下输出 release不打印
 
 - parameter item:
 */
//func zp(_ item: @autoclosure () -> Any) {
//    #if DEBUG
//        print(#file)
//        print(#line)
//        print(item())
//        
//    #endif
//}
func zp<T>(_ messsage : T, file : String = #file, funcName : String = #function, lineNum : Int = #line, isShowDetail:Bool? = nil) {
    
    #if DEBUG
        if isShowDetail == nil || isShowDetail! == true {
            let fileName = (file as NSString).lastPathComponent
            
            print("\(fileName):(\(lineNum)) \(messsage)")
        }else {
            print("\(messsage)")
        }
    #endif
}



/**
 资源锁
 
 - parameter lock:    lock对象
 - parameter closure: 闭包
 */
func synchronized(_ lock:Any,closure:(()->())?){
    objc_sync_enter(lock)
    closure?()
    objc_sync_exit(lock)
}

extension CGSize{
    /** 按比例缩放 */
    func ratioSize(_ ratio: CGFloat) -> CGSize{
        return CGSize(width: self.width / ratio, height: self.height / ratio)
    }
}

