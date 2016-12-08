//
//  PhoneLoginViewController.swift
//  FindWork
//
//  Created by duzhe on 2016/10/26.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import UIKit
import PKHUD

class PhoneLoginViewController: BlackVC {

    @IBOutlet weak var phoneView:UIView!
    @IBOutlet weak var phoneField:UITextField!
    
    @IBOutlet weak var pwdView:UIView!
    @IBOutlet weak var pwdField:UITextField!
    
    @IBOutlet weak var checkNumBtn:UIButton!
    @IBOutlet weak var loginBtn:UIButton!
    
    fileprivate lazy var viewModel:LoginViewModel = LoginViewModel()
    
    fileprivate var label:UILabel!
    var checkTask:Task?
    fileprivate var isWaiting = true
    let totalTimes:Int = 60
    fileprivate var times = 0
    
    var mode = 0 // 0 从登录页面过来 1 其他页面过来 绑定手机操作 3 微信登录
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}


extension PhoneLoginViewController:ZZTask{

    func layoutUI(){
        self.view.backgroundColor = UIColor.standard
        self.checkNumBtn.zz_littleBoderRound()
        phoneView.zz_littleBoderRound()
        pwdView.zz_littleBoderRound()
        loginBtn.zz_littleRound()
        
        label = UILabel()
        self.checkNumBtn.addSubview(label)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 15)
        label.isHidden = true
        label.snp.makeConstraints { (make) in
            make.center.equalTo(checkNumBtn)
        }
        
        if mode == 0{
            self.title = "手机号码登录"
        }else {
            self.title = "绑定手机号码"
        }
        
        checkNumBtn.addTarget(self, action: #selector(getCheckNum), for: UIControlEvents.touchUpInside)
        loginBtn.addTarget(self, action: #selector(login), for: UIControlEvents.touchUpInside)
        if let last_phone = getDefault(__$.last_user_phone) as? String{
            phoneField.text = last_phone
        }
        
    }
    
    /// 点击发送验证码
    func getCheckNum(){
        
        let res = Utils.checkTel(self.phoneField.text)
        if res{
            guard let phone = self.phoneField.text else{ return }
            viewModel.sendIdCode(phone: phone) // 发送短信验证码
            checkNumBtn.isEnabled = false
            times = totalTimes
            isWaiting = true
            checkNumBtn.normal_title = ""
            self.label.isHidden = false
            
            self.label.attributedText = configAttr(times)
            waiting()
        }else{
            cancel(checkTask)
            stopWait()
        }
    }
    
    
    fileprivate func configAttr(_ times:Int) -> NSAttributedString{
        return ("重新发送 ".toAttr().foreColor(UIColor.REMIND_COLOR)
            >>>
                "\(times)".toAttr().foreColor(UIColor.MONEY_REMIND_COLOR) )
    }
    
    func waiting(){
        if !self.isWaiting { return }
        self.isWaiting = true
        self.checkTask = self.delay(1, task: { () -> () in
            self.times -= 1
            self.label.attributedText = self.configAttr(self.times)
            if self.times == 0{
                self.stopWait()
            }else{
                self.waiting()
            }
        })
    }

    
    fileprivate func stopWait(){
        times = totalTimes
        self.isWaiting = false
        label.isHidden = true
        self.checkNumBtn.isEnabled = true
        self.checkNumBtn.normal_title = "发送验证码"
    }
    
    
    func checkField()->Bool{
        if $.k(self.phoneField.text){
            ZZAlert.showAlert(self, meg: "电话号码不能为空")
            return false
        }else if $.k(self.pwdField.text){
            ZZAlert.showAlert(self, meg: "验证码不能为空")
            return false
        }
        return true
    }
    // 登录
    func login(){
        // 隐藏键盘
        $.hideKeyboard()
        
        if !checkField(){
            return
        }
        if mode != 0{
            // 绑定
            guard let phone = self.phoneField.text,let idCode = self.pwdField.text else{
                return
            }
            HUD.show(HUDContentType.progress )
            viewModel.bindPhone(mobile: phone, code: idCode, complete: { [weak self]  (result) in
                HUD.hide(animated: true)
                result.resSuccess({ [weak self] (user) in
                    guard let strongSelf = self else{ return }
                    strongSelf.jumpToIdRegister(user)
                })
            })
        }else{
            // 登录
            guard let phone = self.phoneField.text,let idCode = self.pwdField.text else{ return }
            HUD.show(HUDContentType.progress )
            viewModel.loginWithPhone(mobile: phone, idCode: idCode) { (result) in
                HUD.hide(animated: true)
                result.resSuccess({ [weak self] (user) in
                    guard let strongSelf = self else{ return }
                    strongSelf.jumpToIdRegister(user)
                })
            }
        }
        
    }
    
    
    func jumpToIdRegister(_ user:User){
        
        if $.k(user.userRole) {
            // 如果还没选择过身份 跳转身份选择页面
//            let idRegisterVC = IdRegisterVC(nibName: "IdRegisterVC", bundle: Bundle.main )
//            idRegisterVC.user = user
//            idRegisterVC.mode = self.mode
//            self.navigationController?.pushViewController(idRegisterVC, animated: true)
        }else{
            // 返回提示绑定成功
            if mode == 0 || mode == 3{
                HUD.flash(HUDContentType.label("登录成功") , delay: 1)
                self.navigationController?.dismiss(animated: true, completion: nil)
            }else{
                HUD.flash(HUDContentType.label("绑定成功") , delay: 1)
                _ = self.navigationController?.popViewController(animated: true)
            }
            
        }
    }
}


