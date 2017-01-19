//
//  Refreshable.swift
//  FindWork
//
//  Created by duzhe on 2016/10/12.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import UIKit
import MJRefresh
@objc protocol Refreshable {
    @objc optional var task:URLSessionTask? {
        set get
    }
    var refreshStatus : Int{ set get } // 0 none 1 开始 2 结束
    
    @objc optional func configPullRefresh(_ scrollView:UIScrollView , selector:Selector)
    @objc optional func configPushRefresh(_ scrollView:UIScrollView , selector:Selector)
    
}

extension Refreshable where Self:UIViewController{
    
    // 配置下拉刷新
   func configPullRefresh(_ scrollView:UIScrollView , selector:Selector){
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: selector)
        header?.lastUpdatedTimeLabel.isHidden = true
        header?.stateLabel.isHidden = true
        
        scrollView.mj_header = header
    }
    
    // 配置上拉加载更多
    func configPushRefresh(_ scrollView:UIScrollView , selector:Selector){
        let footer = MJRefreshAutoStateFooter(refreshingTarget: self, refreshingAction: selector)
        footer?.setTitle("-End-", for: MJRefreshState.noMoreData)
        footer?.stateLabel.textColor = UIColor.REMIND_COLOR
        scrollView.mj_footer = footer
        scrollView.mj_footer.isAutomaticallyHidden = true
    }
    
    func endRefresh(_ scrollView:UIScrollView){
        delay(15) { [weak self] in
            guard let strongSelf = self else{ return }
            if strongSelf.refreshStatus == 1{
                strongSelf.task??.cancel()
                scrollView.mj_header.endRefreshing()
                scrollView.mj_footer.endRefreshing()
            }
        }
    }
    
}


