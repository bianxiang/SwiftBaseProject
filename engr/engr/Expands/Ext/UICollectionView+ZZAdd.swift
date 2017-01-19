//
//  UICollectionView+Add.swift
//  zuber
//
//  Created by duzhe on 15/12/13.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit
import SnapKit

extension UICollectionView {
    
    func collectionViewMsgWhenEmpty(_ type:PageType,topMeg:String,message:String,rowCount:Int){
        if rowCount == 0{
            
            let conView = UIView()
            let imgV = UIImageView(image: UIImage(named: type.rawValue))
            conView.addSubview(imgV)
            imgV.snp.makeConstraints{ (make) -> Void in
                make.centerX.equalTo(conView)
                make.centerY.equalTo(conView).offset(-80)
                make.width.equalTo(100)
                make.height.equalTo(100)
            }
            
            
            let topLabel = UILabel()
            conView.addSubview(topLabel)
            topLabel.text = topMeg
            topLabel.textColor = UIColor.QS_COLOR
            topLabel.numberOfLines = 0
            topLabel.textAlignment = NSTextAlignment.center
            topLabel.font = UIFont.systemFont(ofSize: 18)
            topLabel.sizeToFit()
            topLabel.snp.makeConstraints{ (make) -> Void in
                make.centerX.equalTo(conView)
                make.top.equalTo(imgV.snp.bottom).offset(25)
            }
            
            //没有数据
            let messageLabel = UILabel()
            conView.addSubview(messageLabel)
            messageLabel.text = message;
            messageLabel.textColor = UIColor.QS_COLOR
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = NSTextAlignment.center
            messageLabel.font = UIFont.systemFont(ofSize: 13)
            messageLabel.sizeToFit()
            messageLabel.sizeToFit()
            messageLabel.snp.makeConstraints{ (make) -> Void in
                make.centerX.equalTo(conView)
                make.top.equalTo(topLabel.snp.bottom).offset(7)
            }
            
            self.backgroundView = conView
            
        }else{
            //有数据
            self.backgroundView = nil
        }
    }
    
}
