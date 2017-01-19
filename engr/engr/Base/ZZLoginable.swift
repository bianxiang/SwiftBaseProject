//
//  ZZLoginable.swift
//  FindWork
//  处理登录流程
//  Created by duzhe on 2016/11/2.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import Foundation

protocol ZZLoginable {

}

extension ZZLoginable where Self:UIViewController{
    
    func checkLogin()->Bool{
        if ZZGlobal.user == nil {
            //未登录
            autoreleasepool{
                // 弹出登录页面
                let loginVC = LoginViewController(nibName: "LoginViewController", bundle: Bundle.main)
                let navVC = UINavigationController(rootViewController: loginVC)
                self.present(navVC, animated: true, completion: nil)
            }
            return false
        }
//        else if $.k(ZZGlobal.user?.mobile) {
//            // 没有绑定手机 弹出手机绑定页面
//            let phoneLoginVC = PhoneLoginViewController(nibName: "PhoneLoginViewController", bundle: Bundle.main)
//            phoneLoginVC.mode = 1
//            phoneLoginVC.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(phoneLoginVC, animated: true)
//            return false
//        }
//        else if $.k(ZZGlobal.user?.userRole) {
//            // 如果还没选择过身份 跳转身份选择页面
//            let idRegisterVC = IdRegisterVC(nibName: "IdRegisterVC", bundle: Bundle.main )
//            idRegisterVC.hidesBottomBarWhenPushed = true
//            idRegisterVC.user = ZZGlobal.user
//            idRegisterVC.mode = 1
//            self.navigationController?.pushViewController(idRegisterVC, animated: true)
//        }
        return true
    }
    
    
    
    func simpleCheckLogin()->Bool{
        if ZZGlobal.user == nil {
            //未登录
            autoreleasepool{
                // 弹出登录页面
                let loginVC = LoginViewController(nibName: "LoginViewController", bundle: Bundle.main)
                let navVC = UINavigationController(rootViewController: loginVC)
                self.present(navVC, animated: true, completion: nil)
            }
            return false
        }
        return true
    }
}

//class ZZLoginLogic:NSObject{
//    
//    private var vc:UIViewController?
//    
//    func doLogin(vc:UIViewController) {
//        self.vc = vc
//       
//        
//    }
//    
//    func loginSuccess() {
//        
//    }
//    
//    func loginNotSuccess(n: Int, user: User?) {
//        
//    }
//    
//}

