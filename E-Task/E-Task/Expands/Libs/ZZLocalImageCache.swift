//
//  ZZLocalImageCache.swift
//  zuber
//  本地图片缓存
//  Created by duzhe on 16/2/29.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import Foundation
import Kingfisher

typealias _i = ZZLocalImageCache
private let _imgCache = ImageCache(name: "zuber")

struct ZZLocalImageCache{
    
    /**
     保存image到本地沙盒
     
     - parameter data:    data
     - parameter pathkey: 文件名
     */
    static func saveImage(_ data:Data,pathkey:String){
        
        let image = UIImage(data: data)
        if var image = image{
            guard let data = UIImageJPEGRepresentation(image,0.5) else { return }
            image = zipData(data) ?? image
            
            _imgCache.store(image, forKey: pathkey)
//            _imgCache.storeImage(image, forKey: pathkey)
        }
    }
    
    static func zipData(_ data:Data) -> UIImage?{
        var data = data
        var img:UIImage?
        repeat{
            img = UIImage(data: data)
            guard let img = img else { break }
            if let data1 = UIImageJPEGRepresentation(img,0.1){
                data = data1
            }else{
                break
            }
        }while(data.count/1000 > 300)
        
        zp("最后压缩后大小 \(data.count/1000)")
        return img
    }
    
    /**
     根据路径获取image
     
     - parameter pathkey: 文件名
     
     - returns: UIImage对象 可空
     */
    static func getImage(_ pathkey:String,complete:@escaping ((_ img:UIImage)->()),fail:(()->())?){
        ZGCD.zdefault { () -> () in
            _imgCache.retrieveImage(forKey: pathkey, options: nil, completionHandler: { (image, type) in
                if let image = image{
                    ZGCD.main({ () -> () in
                        complete(image)
                    })
                }else{
                    ZGCD.main({ () -> () in
                        fail?()
                    })
                }
            })
        }
    }
    
}
