//
//  ZuberActivity.swift
//  zuber
//
//  Created by duzhe on 15/11/2.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class ZuberActivity: UIView {

    var activityIndicator:UIActivityIndicatorView!
    
    override fileprivate init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(superView:UIView) {
        self.init(frame: CGRect(x: 0, y: 0, width: superView.bounds.width, height: superView.bounds.height))
        superView.addSubview(self)
        superView.bringSubview(toFront: self)
        self.snp.makeConstraints { (make) in
            make.top.bottom.right.left.equalTo(superView)
        }
        self.backgroundColor = UIColor.white
    }
    
    convenience init(superView:UIView,top:CGFloat) {
        self.init(frame: CGRect(x: 0, y: top, width: superView.bounds.width, height: superView.bounds.height-top))
        superView.addSubview(self)
        superView.bringSubview(toFront: self)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startActivity(){
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray

        self.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        activityIndicator.startAnimating()
    }
    
    func stopActivity(){
        if activityIndicator != nil{
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            activityIndicator = nil
            self.removeFromSuperview()
        }
    }
}
