//
//  ImageAsset.swift
//  zuber
//
//  Created by duzhe on 16/3/30.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import UIKit

enum ImageAsset:String{
    case
    Mr = "loading" ,
    Plan = "zz_plan",  // tabbar 首页
    PlanSelected = "zz_plan_selected", // tabbar 首页 选中
    Message = "zz_message",    // tabbar 信息
    MessageSelected = "zz_message_selected",
    User = "zz_me",  // tabbar 我的
    UserSelected = "zz_me_selected" ,  // tabbar 我的 选中
    NavTriggle = "nav_triggle" ,
    NavLoc = "nav_loc" ,
    PubVideoFlag = "pub_video_flag" ,
    PubVideoAdd = "pub_video_add" ,
    PubImageAdd = "pub_image_add" ,
    PubTip = "pub_tip" ,
    PubLoc = "pub_loc" ,
    PubCheckYes = "pub_check_yes" ,
    PubCheckNo = "pub_check_no" ,
    WxCircle = "wx_circle" ,
    WxFriend = "wx_friend" ,
    star_no = "star_no" ,
    star = "star" ,
    Uploading = "uploading" ,
    
    ///我的
    mine_user_head = "mine_user_head",
    mine_header_sex_man = "mine_header_sex_man",
    mine_header_sex_woman = "mine_header_sex_woman",
    mine_icon_reward = "mine_icon_reward",
    mine_icon_credit = "mine_icon_credit",
    mine_icon_address = "mine_icon_address",
    mine_icon_findPeople = "mine_icon_findPeople",
    mine_icon_invite = "mine_icon_invite",
    mine_icon_recharge = "mine_icon_recharge",
    mine_icon_setting = "mine_icon_setting" ,
    mine_invite_bg = "mine_invite_bg",
    mine_invite_bg1 = "mine_invite_bg1",
    mine_invite_bg2 = "mine_invite_bg2",
    mine_icon_advice = "mine_icon_advice",
    
    status_wait_pay = "status_wait_pay" ,
    status_finish = "status_finish",
    price_check_yes = "price_check_yes",
    price_check_no = "price_check_no",
    
    DetailVideo = "detail_video",
    OrderTel = "order_tel" ,
    OrderLoc = "order_loc" ,
    SysMsg = "sys_msg",
    order_alipay = "order_alipay",
    order_wxpay = "order_wxpay"
}

extension ImageAsset{
    var image:UIImage?{
        return UIImage(named: self.rawValue)
    }
}
