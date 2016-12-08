//
//  zuber_disatch.swift
//  zuber
//
//  Created by duzhe on 15/11/12.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

fileprivate let queue = DispatchQueue(label: "zz_personal_queie_serial", attributes: []) //创建一个串行队列

open class ZGCD {
    
    static let back = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
    static let defual = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
    static let high = DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated)
    static let low = DispatchQueue.global(qos: DispatchQoS.QoSClass.utility)
    
    //MARK: - 串行队列
    open static var serialQueue: DispatchQueue {
        return queue
    }
    
    //串行队列
    static func zzSerialQueue(_ content:@escaping (()->())){
         serialQueue.async {
            content()
         }
    }
    
    static func back(_ content:@escaping (()->())){
        back.async {
            content()
        }
    }
    
    static func zdefault(_ content:@escaping (()->())){
        defual.async {
            content()
        }
    }
    
    static func low(_ content:@escaping (()->())){
        low.async {
            content()
        }
    }
    
    static func hight(_ content:@escaping (()->())){
        high.async {
            content()
        }
    }
    
    static func main(_ content:@escaping (()->())){
        DispatchQueue.main.async {
            //主线程执行
            content()
        }
    }
    
    
    static func zd_m(_ content:@escaping (()->()),_ main:@escaping (()->())){
        defual.async {
            content()
            DispatchQueue.main.async {
                //主线程执行
                main()
            }
        }
    }
}
