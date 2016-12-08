//
//  UIImageViewExt.swift
//  zuber
//
//  Created by duzhe on 15/11/12.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {

//    //MARK: -给自己添加圆角的方法 ，背景是白色
//    func addCircleMask(_ color:UIColor = UIColor.white){
//        let zuberMaskView = Zuber_ImageMaskView(frame: self.bounds)
//        self.addSubview(zuberMaskView)
//        zuberMaskView.coverColor = color
//        zuberMaskView.roundedRadius = self.bounds.width/2
//    }

//    func addRectLine(){
//        let borderImage = Zuber_BorderImageView(frame: self.bounds)
//        self.addSubview(borderImage)
//    }
    
    //MARK: -添加圆形半透明边框 让锯齿不那么明显
    func addCircleLine(){
        let avatarBorder = CALayer()
        avatarBorder.frame = self.bounds;
        avatarBorder.borderWidth = 0.5
        avatarBorder.borderColor = UIColor(white: 0.00, alpha: 0.09).cgColor
        avatarBorder.cornerRadius = self.frame.height / 2
        avatarBorder.shouldRasterize = true;
        avatarBorder.rasterizationScale = UIScreen.main.scale;
        self.layer.addSublayer(avatarBorder)
    }
    
    func zz_setImageWithUrl(_ url:String?){
        if let url = url {
            if let url = URL(string: url){
                self.zz_setImageWithURL(url: url, placeholderImage: $.mr())
            }
        }
    }
    
    
    func zz_circleImage(_ avatar:String?){
        self.image = ImageAsset.mine_user_head.image
        if let avatar = avatar{
            if let url = URL(string: avatar){
                //设置圆角
//                self.image = ImageAsset.mine_user_head.image
                self.zz_setImageWithURL(url: url, placeholderImage: ImageAsset.mine_user_head.image, success: { (req, resp, image) in
                    let hoder_img = self.image?.zz_imageByRoundCornerRadius(1000)
                    self.image = hoder_img
                })
            }
        }
    }
    func zz_normalImage(_ avatar:String?){
        if let avatar = avatar{
            if let url = URL(string: avatar){
                //设置圆角
                self.zz_setImageWithURL(url: url, placeholderImage: $.mr())
            }
        }
    }
    
    func zz_roomImage(_ avatar:String?,mr:UIImage?){
        if let avatar = avatar{
            if let url = URL(string: avatar){
                self.image = mr
                self.zz_setImageWithURL(url: url, placeholderImage: mr)
            }
        }
    }
    
    func zz_setImageWithURL(url: URL? ,   placeholderImage: UIImage? ,success:(( _ req:URLRequest? ,_ resp:URLResponse?,_ img:UIImage?  ) -> Void )? = nil){
        if let url = url {
            
            self.kf.setImage(with: url, placeholder: placeholderImage, options: nil , progressBlock: nil , completionHandler: { (img, err, cache , url) in
                success?(nil,nil ,img)
            })
            
        }
        
    }
    
    
    
    func zz_setImage(withUrl:URL? , placeholder:UIImage? =  $.mr() , progressBlock:((Int64,Int64)->())? , success:(( _ req:URLRequest? ,_ resp:URLResponse?,_ img:UIImage? ) -> Void )? ){
        if let url = withUrl {
            // let resource = ImageResource(downloadURL: url)
            self.kf.setImage(with: url, placeholder: placeholder, options: nil , progressBlock: progressBlock , completionHandler: { (img, err, cachetype, url) in
                success?(nil,nil,img)
            })
        }
    }

}
