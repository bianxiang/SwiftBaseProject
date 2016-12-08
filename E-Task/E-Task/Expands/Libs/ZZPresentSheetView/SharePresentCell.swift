//
//  SharePresentCell.swift
//  zuber
//
//  Created by duzhe on 16/8/10.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import UIKit

class SharePresentCell: UICollectionViewCell {

    
    @IBOutlet weak var imageV:UIImageView!
    @IBOutlet weak var nameLabel:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameLabel.textColor = UIColor.CONTENT_COLOR
    }

}
