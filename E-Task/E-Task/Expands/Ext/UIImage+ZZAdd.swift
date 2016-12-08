//
//  UIImageExt.swift
//  UITabBarController
//
//  Created by duzhe on 15/9/3.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

extension UIImage{

    //图像比例缩放
    func scaleImage(_ img:UIImage,scaleSize:CGFloat)->UIImage{
        UIGraphicsBeginImageContext(CGSize(width: img.size.width * scaleSize, height: img.size.height * scaleSize))
        img.draw(in: CGRect(x: 0, y: 0, width: img.size.width * scaleSize, height: img.size.height * scaleSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage!
    }
    
    //自定长宽
    func reSizeImage(_ toSize:CGSize)->UIImage{
        UIGraphicsBeginImageContext(CGSize(width: toSize.width, height: toSize.height));
        self.draw(in: CGRect(x: 0, y: 0, width: toSize.width, height: toSize.height))
        let reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return reSizeImage!;
    }
    
    
    func resizableImage(_ name:String)->UIImage{
        let image = UIImage(named: name)
        let insets = UIEdgeInsetsMake(image!.size.height/2, image!.size.width/2, image!.size.height/2 + 1 , image!.size.width/2 + 1)
        return (image?.resizableImage(withCapInsets: insets, resizingMode: UIImageResizingMode.tile))!
    }
    
    func circleImage()->UIImage{
        // 开启图形上下文
        UIGraphicsBeginImageContext(self.size);
        // 获得上下文
        let ctx = UIGraphicsGetCurrentContext();
        ctx!.setAllowsAntialiasing(true);
        // 矩形框
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height);
        // 添加一个圆
        ctx!.addEllipse(in: rect);
        // 裁剪(裁剪成刚才添加的图形形状)
        ctx!.clip();
        // 往圆上面画一张图片
        self.draw(in: rect)
        // 获得上下文中的图片
        let image = UIGraphicsGetImageFromCurrentImageContext();
        // 关闭图形上下文
        UIGraphicsEndImageContext();
        return image!;
    }
    
    func zz_imageByRoundCornerRadius(_ radius:CGFloat,corners:UIRectCorner,borderWidth:CGFloat,borderColor:UIColor?,borderLineJoin:CGLineJoin)->UIImage{
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale);
        let context = UIGraphicsGetCurrentContext();
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height);
        context!.scaleBy(x: 1, y: -1);
        context!.translateBy(x: 0, y: -rect.size.height);
        
        let minSize = min(self.size.width, self.size.height);
        if borderWidth < minSize / 2 {
            let path = UIBezierPath(roundedRect: rect.insetBy(dx: borderWidth, dy: borderWidth), byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: borderWidth))
            path.close()
            context!.saveGState();
            path.addClip()
            context!.draw(self.cgImage!, in: rect);
            context!.restoreGState();
        }
        
        if borderColor != nil && borderWidth < minSize / 2 && borderWidth > 0 {
            let strokeInset = (floor(borderWidth * self.scale) + 0.5) / self.scale;
            let strokeRect = rect.insetBy(dx: strokeInset, dy: strokeInset);
            let strokeRadius = radius > self.scale / 2 ? radius - self.scale / 2 : 0;
            let path = UIBezierPath(roundedRect: strokeRect, byRoundingCorners: corners, cornerRadii:CGSize(width: strokeRadius, height: borderWidth))
            path.close()
            
            path.lineWidth = borderWidth;
            path.lineJoinStyle = borderLineJoin;
            borderColor?.setStroke()
            path.stroke()
        }
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }
    
    func zz_imageByRoundCornerRadius(_ radius:CGFloat,borderWidth:CGFloat,borderColor:UIColor?)->UIImage{
        return self.zz_imageByRoundCornerRadius(radius, corners: UIRectCorner.allCorners, borderWidth: borderWidth, borderColor: borderColor, borderLineJoin: CGLineJoin.miter)
    }
    
    func zz_imageByRoundCornerRadius(_ radius:CGFloat)->UIImage{
        return self.zz_imageByRoundCornerRadius(radius, borderWidth: 0, borderColor: nil)
    }
    
}
