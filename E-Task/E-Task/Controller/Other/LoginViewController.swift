//
//  LoginViewController.swift
//  FindWork
//
//  Created by duzhe on 2016/10/12.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController , VCConfig{

    
    @IBOutlet weak var wxLoginView:UIView!
    @IBOutlet weak var phoneLoginView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if WXApi.isWXAppSupport() && WXApi.isWXAppInstalled(){
            wxLoginView.isHidden = false
        }else {
            wxLoginView.isHidden = true
        }
        let tapPhone = UITapGestureRecognizer(target: self, action: #selector(clickPhoneLogin))
        phoneLoginView.addGestureRecognizer(tapPhone)
        
        let tapWx = UITapGestureRecognizer(target: self, action: #selector(clickWxLogin))
        wxLoginView.addGestureRecognizer(tapWx)
        
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate{
            appdelegate.authorDelegate = self
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.whiteNavBar() // 透明nav
    }
    
    @IBAction func closeSelf(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func clickPhoneLogin(){
        let phoneLoginVC = PhoneLoginViewController(nibName: "PhoneLoginViewController", bundle: Bundle.main)
        phoneLoginVC.mode = 0
        self.navigationController?.pushViewController(phoneLoginVC, animated: true)
    }
    
    func clickWxLogin(){
        if WXApi.isWXAppSupport() && WXApi.isWXAppInstalled(){
            let request = SendAuthReq()
            request.scope = "snsapi_userinfo"
            request.state = "123"
            WXApi.send(request)
        }else{
//            ZZAlert.showAlert(self, meg: "请先安装微信")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func agreement(_ sender: UIButton) {
        self.navigationController?.pushViewController(UserAgreementController(), animated: true)
    }
    
}

extension LoginViewController:AuthorDelegate{
    
    func loginAuthorSuccess(user: User?) {
        if $.k(user?.mobile) {
            // 绑定电话
            let phoneLoginVC = PhoneLoginViewController(nibName: "PhoneLoginViewController", bundle: Bundle.main)
            phoneLoginVC.mode = 3
            self.navigationController?.pushViewController(phoneLoginVC, animated: true)
        }
//        else if $.k(user?.userRole){
//            // 绑定角色
//            let idRegisterVC = IdRegisterVC(nibName: "IdRegisterVC", bundle: Bundle.main )
//            idRegisterVC.user = user
//            idRegisterVC.mode = 3
//            self.navigationController?.pushViewController(idRegisterVC, animated: true)
//        }
        else {
            // 登录成功
            _ = self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
}
