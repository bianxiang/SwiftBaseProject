//
//  File.swift
//  zuber
//
//  Created by duzhe on 15/12/7.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import Foundation

private let instance = ZZCacheManager()

open class ZZCacheManager:NSObject {
    
    fileprivate var data = NSMutableData()
    fileprivate var keyArchiver:NSKeyedArchiver!
    override init() {
        super.init()
    }
    
    //MARK: -单例
    open class var sharedManager: ZZCacheManager {
        return instance
    }
    
    //MARK: -配置文件夹
    func configFile(_ url:String) ->String{
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentDirectory = paths.first!
        var df = documentDirectory
        df = "\(df)/\(url)"
        return df
    }
    
    //MARK: -从文件获取信息 此处内置配置document前缀 只要传入短链
    func getInfoFromDisk(_ key:String)->Any?{
        let wholeFolder =  self.configFile(key)
        //反归档 获取
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: wholeFolder){
            let mdata = NSMutableData(contentsOfFile:wholeFolder )
            let unArchiver = NSKeyedUnarchiver(forReadingWith: mdata! as Data)
            let u = unArchiver.decodeObject(forKey: key)
            return u as Any?
        }
        return nil
    }
    
    //MARK: - 存储序列化好的模型到document底下的文件   此处内置配置document前缀 只要传入短链
    func saveModelToFile(_ key:String,value:Any?){
        let wholeFolder = self.configFile(key)
        let data = NSMutableData()
        var keyArchiver:NSKeyedArchiver!
        keyArchiver =  NSKeyedArchiver(forWritingWith: data)
        keyArchiver.encode(value, forKey: key)
        keyArchiver.finishEncoding() //归档完毕
        do {
            try data.write(toFile: wholeFolder, options: NSData.WritingOptions.atomic)  //存储
        }catch let err{
            zp("err:\(err)")
        }
    }

}
