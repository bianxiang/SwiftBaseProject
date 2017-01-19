//
//  UITableView+EmptyTable.swift
//  zuber
//
//  Created by duzhe on 15/10/30.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

extension UITableView{
    func clearBottonLines(){
        self.tableFooterView = UIView()
    }
    // MARK: -空table的解决方案
    func tableViewMsgWhenEmpty(_ message:String,rowCount:Int){
        if rowCount == 0{
            //没有数据
            let messageLabel = UILabel()
            // Display a message when the table is empty
            messageLabel.text = message;
            messageLabel.textColor = UIColor.main
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = NSTextAlignment.center
            messageLabel.font = UIFont.systemFont(ofSize: 17)
            messageLabel.sizeToFit()
            self.backgroundView = messageLabel
            messageLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
            messageLabel.sizeToFit()
            self.separatorStyle = UITableViewCellSeparatorStyle.none
        }else{
            //有数据
            self.backgroundView = nil
            self.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        }
    }
    
    
    func tableViewTipText(_ rowCount:Int,messageLabel:UILabel?,source:Int){
        if rowCount == 0{
//            //没有数据
            if source != 0{
                messageLabel?.text = "例如：清河中街99号风口飞小区\r\n注意：我们会对信息进行人工审核，如发现地址信息有误或者虚假，zuber将会移除该信息"
            }else{
                messageLabel?.text = "请填写工作地址，工作地址不确定时，可不填写"
            }
            messageLabel?.textColor = UIColor.darkGray
            messageLabel?.numberOfLines = 0
            messageLabel?.textAlignment = NSTextAlignment.left
            messageLabel?.font = UIFont.systemFont(ofSize: 14)
            self.addSubview(messageLabel!)
            messageLabel?.frame = CGRect(x: 30,y: 10, width: self.frame.width-60, height: self.frame.height)
            messageLabel?.sizeToFit()
            self.separatorStyle = UITableViewCellSeparatorStyle.none
        }else{
            //有数据
            messageLabel?.removeFromSuperview()
            self.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        }
    }
    
    
    func tableViewMsgWhenEmpty(_ type:PageType,topMeg:String?,message:String?,rowCount:Int){
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
            self.separatorStyle = UITableViewCellSeparatorStyle.none
        }else{
            //有数据
            self.backgroundView = nil
            if type == PageType.nodata{
                self.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            }else{
                self.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            }
        }
    }
    
    
    func tableViewMsgWhenEmptyForMessage(_ type:PageType,topMeg:String,message:String,rowCount:Int){
        if rowCount == 0{
            
            let conView = UIView()
            let imgV = UIImageView(image: UIImage(named: type.rawValue))
            conView.addSubview(imgV)
            imgV.snp.makeConstraints{ (make) -> Void in
                make.centerX.equalTo(conView)
                make.centerY.equalTo(conView).offset(20)
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
            self.separatorStyle = UITableViewCellSeparatorStyle.none
        }else{
            //有数据
            self.backgroundView = nil
            if type == PageType.nodata{
                self.separatorStyle = UITableViewCellSeparatorStyle.none
            }else{
                self.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            }
        }
    }
    
    
    func tableViewMsgWhenEmptyForDetail(_ type:PageType,topMeg:String,message:String,rowCount:Int){
        if rowCount == 0{
            
            let conView = UIView()
            let imgV = UIImageView(image: UIImage(named: type.rawValue))
            conView.addSubview(imgV)
            imgV.snp.makeConstraints{ (make) -> Void in
                make.centerX.equalTo(conView)
                make.top.equalTo(conView.snp.bottom).offset(-300)
                make.width.equalTo(155)
                make.height.equalTo(155)
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
                make.top.equalTo(imgV.snp.bottom).offset(5)
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
            self.separatorStyle = UITableViewCellSeparatorStyle.none
        }else{
            //有数据
            self.backgroundView = nil
            if type == PageType.nodata{
                self.separatorStyle = UITableViewCellSeparatorStyle.none
            }else{
                self.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            }
        }
    }
    func tableViewWhenEmpty(_ type:PageType,rowCount:Int){
        switch type {
        case .nodata:
            tableViewMsgWhenEmpty(PageType.nodata, topMeg: "全都被你看光啦", message: "修改筛选条件，查看更多信息", rowCount:rowCount)
        default:
            break
        }
    }
    
    /**
     reload单行
     */
    func zz_reloadIndexPath(_ row:Int,section:Int ,animation:UITableViewRowAnimation ){
        reloadRows(at: [IndexPath(row: row, section: section)], with:animation)
    }
    
}

enum PageType:String{
    case nodata = "nodata"
}





