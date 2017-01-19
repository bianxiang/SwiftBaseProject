//
//  ZoomimgImageVC.swift
//  zuber
//
//  Created by duzhe on 16/8/22.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import UIKit

class ZoomimgImageVC: UIViewController {

    var img:UIImage!
    fileprivate var imgView:UIImageView!
    var bigImgUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = UIScreen.main.bounds.size
        
        imgView = UIImageView()
        self.view.addSubview(imgView)
        imgView.contentMode = .scaleAspectFit
        imgView.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.width.height.equalTo(self.view)
        }
        
        imgView.zz_roomImage(bigImgUrl, mr: img)
    }
    
    
}
