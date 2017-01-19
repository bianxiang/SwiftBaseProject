//
//  AppDelegate.swift
//  E-Task
//
//  Created by 1234 on 2016/12/6.
//  Copyright © 2016年 大白. All rights reserved.
//

import UIKit
enum NetStatus{
    case notReach
    case reach
}
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainVC:MainViewController?
    var loginVC:LoginViewController?
    internal var hostReach:Reachability?
    //MARK: - 第三方回调的代理
    weak var authorDelegate:AuthorDelegate?
//    var rechargeDelegate:RechargeDelegate?
    var wxShareDelegate:WXShareDelegate?
    var wxPayDelegate:WXPayDelegate?

    
    internal var currentStatus = NetStatus.reach{
        didSet{
            if oldValue == NetStatus.notReach && currentStatus == NetStatus.reach{
                //网络从未连接状态切换到连接转状态需要重新绑定socket
                print("网络重新连接上了")
            }
        }
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.registerApp(launchOptions)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
//        let launchVC = UIViewController()
//        if iphone4s {
//            
//            launchVC.view.backgroundColor = UIColor(patternImage: UIImage(named: "ecceiii-640-960")!)
//        }else if iphone5s {
//            
//            launchVC.view.backgroundColor = UIColor(patternImage: UIImage(named: "eccoiii-640-1136")!)
//        }else if iphone6 {
//            
//            launchVC.view.backgroundColor = UIColor(patternImage: UIImage(named: "eccoiii-750-1334")!)
//        }else if iphone6Plus {
//            
//            launchVC.view.backgroundColor = UIColor(patternImage: UIImage(named: "eccoiii-1242-2208")!)
//        }
//        window?.rootViewController = launchVC
        mainVC = MainViewController()
        window?.rootViewController = mainVC
        
        
        application.applicationIconBadgeNumber = 0
        //监听网络状态
        monitorNetwork()
        // 自定义外观
        customizeAppearance()
        window?.makeKeyAndVisible()
        
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
        
        
    }


}

extension AppDelegate{
    //MARK: - 自定义主题
    fileprivate func customizeAppearance(){
        //        UINavigationBar.appearance().ti
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        UINavigationBar.appearance().tintColor = UIColor.main
        
        UITabBar.appearance().tintColor = UIColor.main
    }
    //MARK: 监听网络
    fileprivate func monitorNetwork(){
        //监听网络 状态变化
        // 查看网络是否连接 并监听连接状态
        hostReach = Reachability.forInternetConnection()
        
//        application.isStatusBarHidden = false
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(_:)), name: NSNotification.Name.reachabilityChanged, object: nil)
        hostReach?.startNotifier()
    }
    //MARK: 网络状态改变的通知

    func reachabilityChanged(_ note:Notification){
        zp("========")
        if let curReach = note.object as? Reachability{
            let status = curReach.currentReachabilityStatus()
            if status == .NotReachable{
                currentStatus = NetStatus.notReach
            }else{
                currentStatus = NetStatus.reach
                zp("--------------状态改变----------=====网络连接上了")
            }
        }
    }
}
