//
//  $.swift
//  zuber
//
//  Created by duzhe on 15/12/8.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit
import SafariServices
import SwiftyJSON
import PKHUD

struct $ {
    /**
     替换nil
     
     - parameter str: String?
     - returns: String
     */
    static func nvl(_ str:String?) ->String
    {
        return str ?? ""
    }
    
    static func nvl(_ num:NSNumber?) ->NSNumber
    {
        return num ?? 0
    }
    
    
    /**
     返回默认头像
     
     - returns: UIImage
     */
    static func mr()->UIImage?{
        return ImageAsset.Mr.image
    }
    
    /**
     是否为nil或者""空字串
     
     - parameter str: String?
     
     - returns: Bool
     */
    static func k(_ str:String?)->Bool{
        return (str ?? "").trim() == ""
    }
    
    static func timeStampToString(timeStamp:TimeInterval)->String {
        guard let interval = "\(timeStamp)".substringToIndex(10).toInt() else { return ""
        }
        zp(interval)
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="MM-dd HH:mm"
        let date = Date(timeIntervalSince1970: TimeInterval(interval))
        dfmatter.string(from: date)
        print(dfmatter.string(from: date) )
        return dfmatter.string(from: date)
    }
    
    //MARK: - 时间戳转为年份
    static func timeStampToYear(timeStamp:TimeInterval)->Int {
//        guard let interval = "\(timeStamp)".toInt() else { return 0
//        }
//        zp(timeStamp)
//        let dfmatter = DateFormatter()
//        dfmatter.dateFormat = "yyyy"
//        let date = Date(timeIntervalSince1970: timeStamp)
//        dfmatter.string(from: date)
//        print(dfmatter.string(from: date) )
//
//        return Int(dfmatter.string(from: date))!
        
       
        
        var string = NSString(string: String(timeStamp/1000.0))
        
        var timeSta:TimeInterval = string.doubleValue
        var dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy年MM月dd日"
        
        var date = NSDate(timeIntervalSince1970: timeSta)
        
        print(dfmatter.string(from: date as Date))
        return Int((dfmatter.string(from: date as Date)).substringToIndex(4))!
    }
    
    static func timeStampToString(timeStamp:String)->String {
        if timeStamp.characters.count < 10 {
            return ""
        }
        guard let interval = "\(timeStamp)".substringToIndex(10).toInt() else { return ""
        }
        zp(interval)
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="MM-dd HH:mm"
        let date = Date(timeIntervalSince1970: TimeInterval(interval))
        dfmatter.string(from: date)
        print(dfmatter.string(from: date) )
        return dfmatter.string(from: date)
    }

    
    static func getfileSize(_ path:String)->Double{
        let ouputFileAttr = try? FileManager.default.attributesOfItem(atPath: path)
        if let size = ouputFileAttr?[.size] as? Double{
            return size/1024.0/1024.0
        }
        return 0
    }

//    static func tagsToStrs(tags:[Tag]?)->[String]{
//        guard let tags = tags else { return [] }
//        var strs:[String] = []
//        for tag in tags{
//            strs.append($.nvl(tag.name))
//        }
//        return strs
//    }
//    
//    static func propertysToStrs(propertys:[Property]?)->[String]{
//        guard let propertys = propertys else { return [] }
//        var strs:[String] = []
//        for property in propertys{
//            strs.append("\($.nvl(property.key)) \($.nvl(property.val))颗")
//        }
//        return strs
//    }
    
    static func getHeightWithTag(_ strs:[String],width:CGFloat,fontSize:CGFloat)->CGFloat{
        let w_height:CGFloat = 10
        let h_padding:CGFloat = 10
        var superFrame = CGRect.zero
        var isFirst = true
        if strs.count>0{
            for str in strs {
                let lbWidth = Utils.getTextRectSize(str,size: fontSize )+20
                if isFirst {
                    isFirst = false
                    superFrame = CGRect(x: 0, y: 0, width: lbWidth, height: 34)
                }else{
                    if superFrame.maxX + lbWidth + w_height > width{
                        // 换行
                        superFrame = CGRect(x: 0 , y: superFrame.maxY + h_padding , width: lbWidth , height: 34)
    
                    }else{
                        // 不换行
                        superFrame = CGRect(x: superFrame.maxX + w_height, y: superFrame.origin.y , width: lbWidth, height: 34)
                    }
                }
            }
        }
        return superFrame.maxY + 10 + 10
    }
    
    static func findKeyByValue(dic:[String:String],key:String)->String{
        for (k,v) in dic{
            if k == key {
                return v
            }
        }
        return ""
    }

//    static func changePropertiesAndTagsToStrs(properties:[Property]?,tags:[Tag]?)->[String]{
//        var strs1 = $.propertysToStrs(propertys: properties)
//        let strs2 = $.tagsToStrs(tags:tags)
//        strs1.appendItems(strs2)
//        return strs1
//    }
    
    static func tel(vc:UIViewController , mobile:String){
        ZZAlert.showAlert(vc, meg: "确认拨打\(mobile)", btn1: "取消", btn2: "确认") { (action) in
            if let url = URL(string: "tel://\(mobile)") {
                UIApplication.shared.openURL(url)
            }
            
        }
    }
    
    
    static func isIp5OrLess()->Bool{
        return _sw <= 320
    }
    
    static func changeStatusToStr(status:Int)->String{
        switch status {
        case 1:
            return "订单进行中"
        case 2:
            return "订单已完成，待评价"
        case 3:
            return "未上架"
        case 4:
            return "待支付"
        case 5:
            return "已过期"
        case 6:
            return "已完成"
        default:
            return ""
        }
    }
    
    static func loginOut(){
        _g.user = nil
        setDefault(__$.current_login_user, value: nil)
    }
    
    /**
     连接跳转
     系统几种连接跳转方式跳转规则可访问：https://git.oschina.net/smalldudu/zuber/wikis/zuber-%E4%B8%AD%E7%9A%84%E8%BF%9E%E6%8E%A5%E8%B7%B3%E8%BD%AC
     查看
     - parameter vc:        当前vc
     - parameter urlString: url
     */
//    static func zz_openurl(_ vc:UIViewController,urlString:String){
//        if urlString.hasPrefix("\(__$.ZUBER_PRE)/user/"){
//            
//            let uid = urlString.replace("\(__$.ZUBER_PRE)/user/", new: "")
//            $.zz_goMainPage(vc, uid: uid)
//            
//        }else if urlString.hasPrefix("\(__$.ZUBER_old)/user/"){
//            // 兼容旧版本
//            let uid = urlString.replace("\(__$.ZUBER_old)/user/", new: "")
//            $.zz_goMainPage(vc, uid: uid)
//            
//        }else if urlString.hasPrefix("\(__$.ZUBER_PRE)/room/"){
//            let room_id = urlString.replace("\(__$.ZUBER_PRE)/room/", new: "")
//            $.zz_goDetail(vc, room_id: room_id)
//        }else if urlString == publishPage{
//            //去发布页面
//            zz_goPublished(vc)
//        }else if urlString == publishPage_old{
//            //去发布页面
//            zz_goPublished(vc)
//        }else if (urlString.hasPrefix(__$.ZUBER_PRE)  || urlString.hasPrefix(__$.ZUBER_old)) && ZZNetHelper.isLogin(){
//            //已经登录且是内部链接 则加上参数 访问可以直接是登录状态
//            guard let uid = zuber.c_user?.id else { return }
//            guard let secret = ZZLogin.sharedManager.secret else {return }
//            let timeStamp = Utils.timeStamp()
//            zp("request_method=get&timestamp=\(timeStamp)&secret=\(secret)")
//            let once = "request_method=get&timestamp=\(timeStamp)&secret=\(secret)".zz_MD5
//            let newUrl = urlString+"?uid=\(uid)&scene=\(__$.SCENCE)&once=\(once)&time=\(timeStamp)&source=app_web"
//            zz_openOutUrl(vc, urlString: newUrl)
//        }else{
//            zz_openOutUrl(vc, urlString: urlString)
//        }
//    }
    
//    static func zz_goMainPage(_ vc:UIViewController?,uid:String){
//        let mainVC = ZZPersonalMainVC()
//        mainVC.uid = uid
//        mainVC.hidesBottomBarWhenPushed = true
//        vc?.navigationController?.pushViewController(mainVC, animated: true)
//    }
    
//    static func zz_goDetail(_ vc:UIViewController?,room_id:String){
//        let personalDetail = ZZDetailPageController()
//        personalDetail.room_id = room_id
//        personalDetail.hidesBottomBarWhenPushed = true
//        vc?.navigationController?.pushViewController(personalDetail, animated: true)
//    }
//
//    static func zz_goPublished(_ vc:UIViewController?){
//        let publishVC = PubishedViewController()
//        publishVC.hidesBottomBarWhenPushed = true
//        vc?.navigationController?.pushViewController(publishVC, animated: true)
//    }
//    
//    static func zz_goPublish(_ vc:UIViewController?){
//        let publishVC = PublishViewController(nibName: String(describing: PublishViewController.self), bundle: Bundle.main)
//        publishVC.hidesBottomBarWhenPushed = true
//        vc?.navigationController?.pushViewController(publishVC, animated: true)
//    }
//    
//    static func include(_ value:NSNumber? , values:[NSNumber?])->Bool{
//        return values.filter { (any) -> Bool in
//            return any == value
//        }.count > 0
//    }
//    
//    
//    /**
//     外部连接跳转
//     
//     - parameter vc:        vc
//     - parameter urlString: 连接string
//     */
//    static func zz_openOutUrl(_ vc:UIViewController,urlString:String){
//        
//        //外部连接 分版本跳转
//        if #available(iOS 9.0, *) {
//            zp(urlString)
//            if let URL = URL(string: urlString){
//                let safariViewController = SFSafariViewController(url: URL)
//                safariViewController.view.tintColor = UIColor.MAIN_COLOR
//                vc.present(safariViewController, animated: true, completion: nil)
//            }
//        } else {
//            //ios9以下
//            let webVC = CommonWebVC()
//            webVC.urlString = urlString
//            webVC.url = nil
//            webVC.hidesBottomBarWhenPushed = true
//            vc.navigationController?.pushViewController(webVC, animated: true)
//        }
//        
//    }
//    
//    /**
//     n天之后
//     
//     - parameter n: n
//     
//     - returns: date字串类型
//     */
//    static func nDaysLater(_ n:Int)->String{
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-01"
//        let newDate = Date()
//        let str = dateFormatter.string(from: newDate)
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let firstDate = dateFormatter.date(from: str)
//        let nDaysDate = Date(timeInterval:Double(60*60*24*n), since: firstDate!)
//        return dateFormatter.string(from: nDaysDate)
//    }
//    
//    static func formatDate(_ dateStr:String)->String{
//        var tmpStr = dateStr
//        let y = (tmpStr as NSString).substring(to: 2)
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yy"
//        let nowY = Date()
//        let ys = dateFormatter.string(from: nowY)
//        if ys == y{
//            return "\((tmpStr as NSString).substring(from: 3).replace("-", new: "月"))日"
//        }else{
//            
//            let range = Range<String.Index>( tmpStr.characters.index(tmpStr.startIndex, offsetBy: 2) ..< tmpStr.characters.index(tmpStr.startIndex, offsetBy: 3))
//            tmpStr.replaceSubrange(range, with: "年")
//            return "\(tmpStr.replace("-", new: "月"))日"
//        }
//    }
    
    /**
     开启红外感应
     */
    static func enableSence(){
        UIDevice.current.isProximityMonitoringEnabled = true
    }
    
    /**
     关闭红外感应
     */
    static func diableSence(){
        UIDevice.current.isProximityMonitoringEnabled = false
    }
    
    /**
     隐藏键盘
     */
    static func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),to: nil, from: nil, for: nil)
    }
    
    /**
     去设置页面开启某选项
     
     - parameter vc:   vc
     - parameter type: 类型
     */
//    static func goSetting(_ vc:UIViewController,type:SettingType){
//        
//        var title = ""
//        var msg = ""
//        
//        switch type{
//        case .location:
//            title = kCantPos
//            msg = kPosMsg
//        case .voice:
//            title = "未获取到麦克风权限"
//            msg = "请在手机设置中开启麦克风使用权限"
//        }
//        
//        DispatchQueue.main.async(execute: { () -> Void in
//            //提示去设置开启定位
//            let alertController = UIAlertController(title:title,
//                message:msg ,
//                preferredStyle: .alert)
//            let cancelAction = UIAlertAction(title:"取消", style: .cancel, handler:nil)
//            let settingsAction = UIAlertAction(title: "立即开启", style: .default, handler: { (action) -> Void in
//                if let url = URL(string: UIApplicationOpenSettingsURLString){
//                    if UIApplication.shared.canOpenURL(url){
//                        UIApplication.shared.openURL(url)
//                    }
//                }
//            })
//            alertController.addAction(cancelAction)
//            alertController.addAction(settingsAction)
//            vc.present(alertController, animated: true, completion: nil)
//        })
//    }
    
//    /**
//     豆瓣授权
//     
//     - parameter vc: UIViewController
//     */
//    static func doubanOAuth(_ vc:UIViewController,delegate:CommonWebVCDelegate){
//        let webVC = CommonWebVC()
//        webVC.urlString = __$.dbOAuth
//        webVC.isDouban = true
//        webVC.delegate = delegate
//        webVC.url = nil
//        webVC.hidesBottomBarWhenPushed = true
//        vc.navigationController?.pushViewController(webVC, animated: true)
//    }

    
//    static func textHeifhtWithText(_ zzText:String,wid:CGFloat,font:UIFont)->CGFloat{
//        let content = NSMutableAttributedString(string: zzText)
//        let framesetterRef = CTFramesetterCreateWithAttributedString(content)
//        // 粗略的高度，该高度不准，仅供参考
//        let suggestSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetterRef, CFRangeMake(0, content.length),nil,CGSize(width: wid, height: CGFloat.greatestFiniteMagnitude), nil)
//        
//        let pathRef = CGMutablePath()
//        
//        pathRef.addRect(CGRect(x: 0, y: 0, width: wid, height: suggestSize.height))
////        CGPathAddRect(pathRef, nil, CGRect(x: 0, y: 0, width: wid, height: suggestSize.height))
//        let frameRef = CTFramesetterCreateFrame(framesetterRef,  CFRangeMake(0, content.length), pathRef, nil)
//     
//        let lines = CTFrameGetLines(frameRef)
//        let lineCount = CFArrayGetCount(lines)
//        
//        // 总高度 = 行数*每行的高度，其中每行的高度为指定的值，不同字体大小不一样
//        let accurateHeight = CGFloat(lineCount) * (font.pointSize * kPerLineRatio);
//        let height = accurateHeight
//        return height
//    }
    
    
//    static func textHeifhtWithText(_ zzText:NSAttributedString,wid:CGFloat,font:UIFont)->CGFloat{
//        
//        let framesetterRef = CTFramesetterCreateWithAttributedString(zzText)
//        // 粗略的高度，该高度不准，仅供参考
//        let suggestSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetterRef, CFRangeMake(0, zzText.length),nil,CGSize(width: wid, height: CGFloat.greatestFiniteMagnitude), nil)
//        
//        let pathRef = CGMutablePath()
//        pathRef.addRect(CGRect(x: 0, y: 0, width: wid, height: suggestSize.height))
////        CGPathAddRect(pathRef, nil, CGRect(x: 0, y: 0, width: wid, height: suggestSize.height))
//        let frameRef = CTFramesetterCreateFrame(framesetterRef,  CFRangeMake(0, zzText.length), pathRef, nil)
//        
//        let lines = CTFrameGetLines(frameRef)
//        let lineCount = CFArrayGetCount(lines)
//        
//        
//        var ascent:CGFloat = 0
//        var descent:CGFloat = 0
//        var leading:CGFloat = 0
//        
//        var totalHeight:CGFloat = 0
//        
//        
//        for i in 0..<lineCount{
//            
//            let lineRef = unsafeBitCast(CFArrayGetValueAtIndex(lines, i),to: CTLine.self)
//            CTLineGetTypographicBounds(lineRef, &ascent, &descent, &leading)
//            totalHeight += ascent+descent
//            
//        }
//        
////        // 总高度 = 行数*每行的高度，其中每行的高度为指定的值，不同字体大小不一样
////        let accurateHeight = CGFloat(lineCount) * (font.pointSize * kPerLineRatio);
////        
////        let height = accurateHeight
//        
//        return totalHeight
//    }
    
    
//    static func zzTextSize(_ zzText:String,wid:CGFloat)->CGSize{
//        let content = NSMutableAttributedString(string: zzText)
//        content.addAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 16)], range: NSMakeRange(0, content.length))
//        //创建CTFramesetterRef实例
//        let frameSetter = CTFramesetterCreateWithAttributedString(content)
//        
//        // 获得要绘制区域的高度
//        let restrictSize = CGSize(width: wid, height: CGFloat.greatestFiniteMagnitude)
//        let coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(0, 0) , nil, restrictSize, nil)
//        let textHeight = coreTextSize.height
//        let textWidth = coreTextSize.width
////        zp("行高度为---\(textHeight)")
////        let height = textHeifhtWithText(zzText,wid:wid,font:UIFont.systemFontOfSize(16))
//        return CGSize(width: textWidth, height:textHeight < 19 ? 19:textHeight)
//    }
//    
//    static func ZZAttrTextSize(_ attrTxt:NSAttributedString,wid:CGFloat,size:CGFloat)->CGSize{
//        
//        let frameSetter = CTFramesetterCreateWithAttributedString(attrTxt)
//        
//        // 获得要绘制区域的高度
//        let restrictSize = CGSize(width: wid, height: CGFloat.greatestFiniteMagnitude)
//        let coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(0, 0) , nil, restrictSize, nil)
//        let textHeight = coreTextSize.height
//        let textWidth = coreTextSize.width
//
////        let height = textHeifhtWithText(attrTxt.string,wid:wid,font:UIFont.systemFontOfSize(16))
//        return CGSize(width: textWidth, height: textHeight)
//    }
//
//    static func f14()->UIFont{
//        return UIFont.systemFont(ofSize: 14)
//    }
//    static func f13()->UIFont{
//        return UIFont.systemFont(ofSize: 13)
//    }
//    static func f12()->UIFont{
//        return UIFont.systemFont(ofSize: 12)
//    }
//    static func f11()->UIFont{
//        return UIFont.systemFont(ofSize: 11)
//    }
//    static func f15()->UIFont{
//        return UIFont.systemFont(ofSize: 15)
//    }
//    static func f16()->UIFont{
//        return UIFont.systemFont(ofSize: 16)
//    }
//
//    static let back = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
//    static let defual = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
//    static let high = DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated)
//    static let low = DispatchQueue.global(qos: DispatchQoS.QoSClass.utility)
//    
//    static func zz_back_main(_ back:(()->())?,main:(()->())?){
//        defual.async {
//            back?()
//            DispatchQueue.main.async {
//                //主线程执行
//                main?()
//            }
//        }
//    }
//    
//    static func getQZAttrs()->[String:AnyObject]{
//        let style = NSMutableParagraphStyle()
//        style.lineSpacing = 3
//        return [NSFontAttributeName:UIFont.systemFont(ofSize: 12),NSParagraphStyleAttributeName:style ]
//    }
//    
//    static func ext(_ ext:String?,p:Int)->String?{
//        if let ext = ext{
//            let arr = ext.components(separatedBy: ",")
//            if arr.count > p{
//                return arr[p]
//            }
//        }
//        return nil
//    }
//    
//    
//    static func isPublishNew() -> Bool{
//        return  Int(zuber.c_user?.room_count ?? 0) == 0
//    }
//    
//    static func presentShareWithType(_ vc:UIViewController,type:ShareType , handler:@escaping ((_ type:ShareTap)->())){
//        var items:[ShareItem] = []
//        //确定安装了微信安装微信
//        if WXApi.isWXAppSupport() && WXApi.isWXAppInstalled(){
//            items.append( ShareItem(name:"微信",img:ImageAsset.WxShare.image))
//            items.append( ShareItem(name:"朋友圈",img:ImageAsset.WxCircleShare.image))
//        }
//        items.append(ShareItem(name:"微博",img:ImageAsset.SinaShare.image))  // 微博
//        
//        if type == ShareType.all{
//            // 举报 复制
//            items.append(ShareItem(name:"举报",img:ImageAsset.Report.image))
//            items.append(ShareItem(name:"复制",img:ImageAsset.LinkCopy.image))
//        }else if  type == ShareType.selfEdite{
//            // 编辑 复制
//            items.append(ShareItem(name:"编辑",img:ImageAsset.DetailEdit.image))
//            items.append(ShareItem(name:"复制",img:ImageAsset.LinkCopy.image))
//        }
//        
//        
//        vc.zz_sharepresentController(items ,clickItemHandler: { (index) in
//            let item = items[index]
//            switch item.name{
//            case "微信":
//                handler(.wx)
//            case "朋友圈":
//                handler(.circle)
//            case "微博":
//                handler(.wb)
//            case "举报":
//                handler(.report)
//            case "复制":
//                handler(.copy)
//            case "编辑":
//                handler(.edit)
//            default:
//                break
//            }
//            
//        })
//    }
}

func scope(_ content: (()->())){
    content()
}


//enum ShareTap{
//    case wx
//    case circle
//    case wb
//    case report
//    case copy
//    case edit
//}
//
//enum SettingType{
//    case voice //麦克风
//    case location   //定位
////    case Photo  //相册
//}

















