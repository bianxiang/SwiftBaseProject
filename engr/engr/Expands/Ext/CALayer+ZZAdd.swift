//
//  CALayer+Add.swift
//  DZImageScan
//
//  Created by duzhe on 15/12/7.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

extension CALayer{
    
    public var zz_center:CGPoint{
        set(v){
            var frame = self.frame
            frame.origin.x = v.x - frame.size.width * 0.5;
            frame.origin.y = v.y - frame.size.height * 0.5;
            self.frame = frame
        }
        get{
            return CGPoint(x: self.frame.origin.x + self.frame.size.width * 0.5,y: self.frame.origin.y + self.frame.size.height * 0.5)
        }
    }
    
    public var zz_transformScale:CGFloat{
        set(v){
            self.setValue(v, forKey: "transform.scale")
        }
        get{
            let v = self.value(forKey: "transform.scale")
            return v as! CGFloat;
        }
    }
    
    func zz_addFadeAnimationWithDuration(_ duration:TimeInterval , curve:UIViewAnimationCurve){
        if (duration <= 0){
            return
        }
        var mediaFunction = ""
        switch (curve) {
        case UIViewAnimationCurve.easeInOut:
            mediaFunction = kCAMediaTimingFunctionEaseOut;

        case UIViewAnimationCurve.easeIn:
            mediaFunction = kCAMediaTimingFunctionEaseIn;
        case UIViewAnimationCurve.easeOut:
            mediaFunction = kCAMediaTimingFunctionEaseInEaseOut;
        case UIViewAnimationCurve.linear:
            mediaFunction = kCAMediaTimingFunctionLinear;
        }
        
        
        let transition =   CATransition()
        transition.duration = duration;
        transition.timingFunction =    CAMediaTimingFunction(name: mediaFunction)
        transition.type = kCATransitionFade;
        self.add(transition, forKey: "zzphoto.fade")
    }
    
    func zz_removePreviousFadeAnimation(){
        self.removeAnimation(forKey: "zzphoto.fade")
    }

    static func createPictureMsgLayer(_ view:UIView)->CAShapeLayer{
        
        let wid = view.frame.width
        let hei = view.frame.height
        
        let rightSpace:CGFloat = 10.0
        let topSpace:CGFloat  = 15.0
        
        let point1 = CGPoint(x: 0, y: 0)
        let point2 = CGPoint(x: wid-rightSpace, y: 0)
        let point3 = CGPoint(x: wid-rightSpace, y: topSpace)
        let point4 = CGPoint(x: wid, y: topSpace)
        let point5 = CGPoint(x: wid - rightSpace, y: topSpace+10.0)
        let point6 = CGPoint(x: wid-rightSpace, y: hei)
        let point7 = CGPoint(x: 0, y: hei)
        
        let path = UIBezierPath()
        path.move(to: point1)
        path.addLine(to: point2)
        path.addLine(to: point3)
        path.addLine(to: point4)
        path.addLine(to: point5)
        path.addLine(to: point6)
        path.addLine(to: point7)
        path.close()
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        
        return layer
    }

    
}
