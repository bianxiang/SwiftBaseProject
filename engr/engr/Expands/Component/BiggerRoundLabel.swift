//
//  BiggerRoundLabel.swift
//  FindWork
//
//  Created by duzhe on 2016/10/25.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import UIKit

class BiggerRoundLabel: UILabel {


    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width+10, height: 30)
    }
    
    
}
