//
//  UIView+Ad.swift
//  DZImageScan
//
//  Created by duzhe on 15/12/7.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit


let zz_color_boder = UIColor(red: 0xDE/255.0, green: 0xDF/255.0, blue:0xE0/255.0, alpha: 1.0)
extension UIView{
    
    var zz_height:CGFloat{
        set(v){
            self.frame.size.height = v
        }
        get{
            return self.frame.size.height
        }
    }
    
    var zz_width:CGFloat{
        set(v){
            self.frame.size.width = v
        }
        get{
            return self.frame.size.width
        }
    }
    
    func zz_snapShotImage()->UIImage{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let snap = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snap!
    }
    
    
    func zz_snapshotImageAfterScreenUpdates(_ afterUpdates:Bool)->UIImage{
        return self.zz_snapShotImage()
    }
    
    var zz_size:CGSize{
        set(v){
            self.frame.size = v
        }
        get{
            return self.frame.size
        }
    }
    
    public var zz_left:CGFloat{
        set(new){
            self.frame.origin.x = new
        }
        get{
            return self.frame.origin.x
        }
    }
    
    public var zz_right:CGFloat{
        set(new){
            self.frame.origin.x = new
        }
        get{
            return  self.frame.origin.x + self.frame.size.width
        }
    }
    
    public var zz_top:CGFloat{
        set(v){
            frame.origin.y = v
        }
        get{
            return self.frame.origin.y
        }
    }
    
    public var zz_bottom:CGFloat{
        set(v){
            self.frame.origin.y = v - self.frame.size.height
        }
        get{
            return self.frame.origin.y + self.frame.size.height
        }
    }
    
    
    public var zz_origin:CGPoint{
        set(v){
            self.frame.origin = v
        }
        get{
            return self.frame.origin
        }
    }
    
    //设置小圆边角
    public func zz_setBorder(){
        self.layer.cornerRadius = 5
        self.layer.borderColor = zz_color_boder.cgColor
        self.layer.borderWidth = 0.5
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    //查找vc
    func responderViewController() -> UIViewController {
        var responder: UIResponder! = nil
        var next = self.superview
        while next != nil {
            responder = next?.next
            if (responder!.isKind(of: UIViewController.self)){
                return (responder as! UIViewController)
            }
            next = next?.superview
        }
        
        return (responder as! UIViewController)
    }
    
    func findFirstResponder()->UIView?{
        
        if self.isFirstResponder{
            return self
        }
        for subView in self.subviews{
            let view = subView.findFirstResponder()
            if view != nil {
                return view
            }
        }
        return nil
    }
    
    func zz_removeAllSubviews(){
        for item in self.subviews{
            item.removeFromSuperview()
        }
    }
    
    func zz_littleBoderRound(){
        self.layer.borderColor = UIColor.BORDER_COLOR.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 3
        self.layer.masksToBounds = true
    }
    
    func zz_noBoderRound(){
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 0
    }
    
    
    func zz_littleRound(){
        self.layer.cornerRadius = 3
        self.layer.masksToBounds = true
    }
    
}


