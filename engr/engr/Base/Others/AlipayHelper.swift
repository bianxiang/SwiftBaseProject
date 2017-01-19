//
//  AlipayHelper.swift
//  FindWork
//
//  Created by duzhe on 2016/11/4.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import Foundation
import PKHUD

struct AlipayHelper {
    /*
    static func alipay(_ charges:ChargeOrders,completion:@escaping (ZZResult<Bool>) -> Void ){
 */
        // ==================================================================== //
        // ============================支付宝移动支付============================ //
        // ==================================================================== //
        
//        let privateKey = charges.sign
        
//        zp(privateKey)
        
//        let order = Order()
//        order.partner = partner  // 合作商户ID
//        order.sellerID = sellerID //卖家支付宝账号对应的支付宝唯一用户号(以2088开头的16位纯数字),订单支付金额将打入该账户,一个partner可以对应多个seller_id。
//        order.service = "mobile.securitypay.pay"
//        order.paymentType = "1"
//        order.inputCharset = "utf-8"
////        order.appID = "2016102602345263"
//        order.showURL = "m.alipay.com"
//        
//        order.outTradeNO = $.nvl(charges.charge?.chargeSn) //订单ID（由商家自行制定)
//        order.subject = $.nvl(charges.charge?.subject)  //商品标题
//        order.body = $.nvl(charges.charge?.subject) //商品描述
//        order.totalFee = "0.01" //$.nvl(account.total_fee) //商品价格
//        order.notifyURL =  $.nvl(charges.notifyUrl) //回调URL
//        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    /*
        let appScheme = "tmpWorkAliPay"
 */
//        let orderDesc = orderStr(order, partner: partner, sellerID: sellerID)
//        "partner=\"\(partner)\"&seller_id=\"\(sellerID)\"&out_trade_no=\"\($.nvl(order.outTradeNO))\"&subject=\"\($.nvl(order.subject))\"&body=\"\($.nvl(order.body))\"&total_fee=\"\($.nvl(order.totalFee))\"&notify_url=\"\($.nvl(order.notifyURL))\"&service=\"mobile.securitypay.pay\"&payment_type=\"1\"&_input_charset=\"utf-8\"&it_b_pay=\"90m\" &return_url=\"\($.nvl(order.showURL))\""
        
        //将商品信息拼接成字符串
//        zp("orderSpec===\(orderDesc)")
        //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//        let signedString = $.nvl(charges.sign)
        
        //将签名成功字符串格式化为订单字符串,请严格按照该格式
//        var orderString:String = ""
//        orderString = "\(charges.orderInfoStr)&sign=\"\(signedString)\"&sign_type=\"RSA\""
    /*
        AlipaySDK.defaultService().payOrder(charges.orderInfoStr, fromScheme: appScheme, callback: { (resultDic) in
            HUD.hide()   // 隐藏 等待框 防止无回调
            zp(resultDic)
            completion(.success(true))
        })*/
//            complete(orderString,appScheme)
/*
     }
*/
    
    
//    static func orderStr(_ order:Order,partner:String , sellerID:String)->String{
//        var orderInfo = "partner=" + "\"" + partner + "\""
//        orderInfo += "&seller_id=" + "\"" + sellerID + "\""
//        orderInfo += "&out_trade_no=" + "\"" + $.nvl(order.outTradeNO) + "\""
//        orderInfo += "&subject=" + "\"" + $.nvl(order.subject) + "\""
//        orderInfo += "&body=" + "\"" + $.nvl(order.body) + "\""
//        orderInfo += "&total_fee=" + "\"" + $.nvl(order.totalFee) + "\""
//        orderInfo += "&notify_url=" + "\"" + $.nvl(order.notifyURL) + "\""
//        orderInfo += "&service=\"mobile.securitypay.pay\""
//        orderInfo += "&payment_type=\"1\""
//        orderInfo += "&_input_charset=\"utf-8\""
//        orderInfo += "&it_b_pay=\"90m\""
//        orderInfo += "&return_url=\"" + $.nvl(order.showURL) + "\"";
//        return orderInfo
//    }
    
}




