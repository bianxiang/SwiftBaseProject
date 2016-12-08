//
//  MainViewController.swift
//  FindWork
//
//  Created by duzhe on 2016/10/12.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController,UITabBarControllerDelegate{
//    var _locService = BMKLocationService()
    
    
    var planVC : PlanViewController!
    var messageVC : MessageViewController!
    var meVC : MeViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        _locService.delegate = self
//        _locService.startUserLocationService()
        
        addChildViewControllers()
    }
//    func didUpdate(_ userLocation: BMKUserLocation!) {
//        _g.latitude = userLocation.location.coordinate.latitude
//        _g.longitude = userLocation.location.coordinate.longitude
//        
//    }
    
    
    /// 添加所有子控制器
    fileprivate func addChildViewControllers() {
         planVC = PlanViewController()
        addChildViewController(planVC, image:ImageAsset.Plan.image ,selectedImage:ImageAsset.PlanSelected.image,title: "计划")
        
         messageVC = MessageViewController()
        addChildViewController(messageVC, image:ImageAsset.Message.image ,selectedImage:ImageAsset.MessageSelected.image,title: "消息")
        
//        let meVC = MeViewController()
//        addChildViewController(meVC, image:ImageAsset.User.image ,selectedImage:ImageAsset.UserSelected.image,title: "我")
         meVC = MeViewController()
        addChildViewController(meVC, image:ImageAsset.User.image ,selectedImage:ImageAsset.UserSelected.image,title: "我")
        self.delegate = self
    }
    
    /// 添加独立的子控制器
    /// - parameter vc:        视图控制器
    /// - parameter imageName: 图像名称
    fileprivate func addChildViewController(_ vc: UIViewController, image: UIImage?,selectedImage:UIImage?,title:String) {
        vc.tabBarItem.image = image?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        vc.tabBarItem.selectedImage = selectedImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        vc.tabBarItem.title = title
        let nav = UINavigationController(rootViewController: vc)
        // 添加控制器
        addChildViewController(nav)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
       
        let index = self.viewControllers?.index(of: viewController)!
       
        switch Int(index!) {
        case 0:
//            homeVC.loadMetadata()
            break
        case 1:
//            _ = orderVC.checkLogin()
            break
        case 2:
//            _ = meVC.checkLogin()
            break
        default:
            break
        }
    }
}
