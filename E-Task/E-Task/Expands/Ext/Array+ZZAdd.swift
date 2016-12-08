//
//  Array+Add.swift
//  zuber
//
//  Created by duzhe on 16/3/15.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import UIKit

//extension Collection where Iterator.Element == Int {
//    public var color: UIColor {
//        guard self.count == 3 else { fatalError("You should specify R,G,B values with 3 integers") }
//        let r = CGFloat(self[startIndex]) / CGFloat(255)
//        let g = CGFloat(self[index.index(startIndex, offsetBy: 1)]) / CGFloat(255)
//        let b = CGFloat(self[index.index(startIndex, offsetBy: 2)]) / CGFloat(255)
//        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
//    }
//}


extension Array{
    
    public func safeIndex(_ i : Int) -> Element? {
        if i < self.count && i >= 0 {
            return self[i]
        } else {
            return nil
        }
    }
    
    subscript(input:[Int])->ArraySlice<Element>{
        get{
            
            var result = ArraySlice<Element>()
            for i in input{
                assert(i<self.count,"数组越界")
                result.append(self[i])
            }
            return result
        }
        
        set{
            
            for (index,i) in input.enumerated(){
                assert(i<self.count,"数组越界")
                self[i] = newValue[index]
            }
        }
    }
    
    subscript(first:Int,second:Int,other:Int...)->ArraySlice<Element>{
        get{
            var result = ArraySlice<Element>()
            var tmp = other
            tmp.insert(second, at: 0)
            tmp.insert(first, at: 0)
            for i in tmp{
                assert(i<self.count,"数组越界")
                result.append(self[i])
            }
            return result
        }
        
        set{
            var tmp = other
            tmp.insert(second, at: 0)
            tmp.insert(first, at: 0)
            for (index,i) in tmp.enumerated(){
                assert(i<self.count,"数组越界")
                self[i] = newValue[index]
            }
        }
    }
    
    mutating func appendItems(_ items:[Element]){
        items.forEach { (t) in
            self.append(t)
        }
    }
}





////我们的 Array 的灵活性就⼤⼤增强了
//var arr3 = [1,2,3,4,5]
//arr3[[0,3]]
//print(arr3)
//arr3[[0,3]] = [9,-200]
//print(arr3)
//
//arr3[0,2,3]
//arr3[2,1] = [-90,-88]
//arr3

//var arr3 = [1,2,3,4,5]
//print(arr3.safeIndex(2))






