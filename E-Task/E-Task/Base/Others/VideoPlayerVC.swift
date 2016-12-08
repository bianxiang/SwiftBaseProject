//
//  VideoPlayerVC.swift
//  zuber
//
//  Created by duzhe on 16/8/18.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import UIKit
import BMPlayer

class VideoPlayerVC: UIViewController {
    var player:BMPlayer!

    var url:URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        let delegate = UIApplication.shared.delegate as? AppDelegate
//        delegate?.alowRotate = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}

extension VideoPlayerVC{
    
    func layoutUI(){
        self.view.backgroundColor = UIColor.BLACK_COLOR
        
        player = BMPlayer()
        view.addSubview(player)
        player.snp.makeConstraints { (make) in
//            make.center.equalTo(self.view)
            make.left.right.equalTo(self.view)
            make.top.bottom.equalTo(self.view)
            // 注意此处，宽高比 16:9 优先级比 1000 低就行，在因为 iPhone 4S 宽高比不是 16：9
//            make.height.equalTo(player.snp.width).multipliedBy(9.0/16.0).priority(750)
        }
        
        player.backBlock = { [weak self] in
            guard let strongSelf = self else{ return }
            strongSelf.dismiss(animated: true, completion: nil)
        }
        
        if let url = url {
            player.playWithURL(url, title: "")
        }
        
    }
    
}
