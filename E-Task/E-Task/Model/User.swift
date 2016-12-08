//
//  User.swift
//  FindWork
//
//  Created by duzhe on 2016/10/25.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import Foundation
import ObjectMapper

enum UserIdentifer:String{
    case none = ""      // 身份不定
    case boss = "boss"  // 工厂主
    case worker = "worker" // 打工者
}

class User : NSObject,NSCoding,Mappable{

    var id:Int = 0
    var nickName = ""
    var bindId:String?
    var mobile:String?
    var imgUrl :String?
    var thumbUrl = ""
    var sex:Int = 0
    var token:String?
    var tempToken:String?
    var userRole:String?
    var boss:Bool = false
    
//    var oftenAdrrs:[AddressInfo]?
    
    var account = 0
    var rewardAccount = 2000
    var avgScore = 0.0
    var age = 0
    
    var birthday:TimeInterval = 0
    
    var totalTw = 0
    var totalScore = 0
    var totalWorker = 0
    var avaBalance = 0
    
    var updateUserInfoParams:[String:Any] {
            return ["nickName":nickName,"sex":sex,"imgUrl":$.nvl(imgUrl),"thumbUrl":thumbUrl ,"birthday":birthday]
    }
    
    override init(){
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        nickName <- map["nickName"]
        id <- map["id"]
        bindId <- map["bindId"]
        mobile <- map["mobile"]
        imgUrl <- map["imgUrl"]
        sex <- map["sex"]
        token <- map["token"]
        tempToken <- map["tempToken"]
        
        userRole <- map["userRole"]
        boss <- map["boss"]
//        oftenAdrrs <- map["oftenAdrrs"]
        
        account <- map["account"]
        rewardAccount <- map["rewardAccount"]
        avgScore <- map["avgScore"]
        birthday <- map["birthday"]
        
        age <- map["age"]
        
        totalTw <- map["totalTw"]
        totalScore <- map["totalScore"]
        totalWorker <- map["totalWorker"]
        thumbUrl <- map["thumbUrl"]
        avaBalance <- map["avaBalance"]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(nickName, forKey: "nickName")
        aCoder.encode(bindId, forKey: "bindId")
        aCoder.encode(mobile, forKey: "mobile")
        aCoder.encode(imgUrl, forKey: "imgUrl")
        aCoder.encode(sex, forKey: "sex")
        aCoder.encode(token, forKey: "token")
        aCoder.encode(tempToken, forKey: "tempToken")
        aCoder.encode(userRole, forKey: "userRole")
        aCoder.encode(boss, forKey: "boss")
//        aCoder.encode(oftenAdrrs, forKey: "oftenAdrrs")
        
        aCoder.encode(account, forKey: "account")
        aCoder.encode(rewardAccount, forKey: "rewardAccount")
        aCoder.encode(avgScore, forKey: "avgScore")
//        aCoder.encode(birthday, forKey: "birthday")
        aCoder.encode(age, forKey: "age")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeInteger(forKey: "id")
        nickName = aDecoder.decodeObject(forKey: "nickName") as! String
        bindId = aDecoder.decodeObject(forKey: "bindId") as? String
        mobile = aDecoder.decodeObject(forKey: "mobile") as? String
        imgUrl = aDecoder.decodeObject(forKey: "imgUrl") as? String
        sex = aDecoder.decodeInteger(forKey: "sex")
        token = aDecoder.decodeObject(forKey: "token") as? String
        tempToken = aDecoder.decodeObject(forKey: "tempToken") as? String
        
        userRole = aDecoder.decodeObject(forKey: "userRole") as? String
        boss = aDecoder.decodeBool(forKey: "boss")
//        oftenAdrrs = aDecoder.decodeObject(forKey: "oftenAdrrs") as? [AddressInfo]
        
        account = aDecoder.decodeInteger(forKey: "account")
        rewardAccount = aDecoder.decodeInteger(forKey: "rewardAccount")
        avgScore = aDecoder.decodeDouble(forKey: "avgScore")
        
//        birthday = aDecoder.decodeObject(forKey: "birthday") as! TimeInterval
        age = aDecoder.decodeInteger(forKey: "age")
    }
    
}
