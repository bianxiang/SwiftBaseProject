//
//  BlackBack.swift
//  FindWork
//
//  Created by duzhe on 2016/10/25.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import Foundation
import PKHUD

class BlackVC:UIViewController,VCConfig {
    
    var backBar:UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBar = UIBarButtonItem(image: UIImage(named: "left_back") , landscapeImagePhone: UIImage(named: "left_back"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(BlackVC.backOP))
        let nagativeSpacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        nagativeSpacer.width = 2
        self.navigationItem.leftBarButtonItems = [nagativeSpacer,backBar]
        
        //对键盘的状态(弹出、收回)进行监控，当键盘状态发生改变时，在相应的方法中对输入框的位置进行操作
        NotificationCenter.default.addObserver(self, selector:#selector(keyBoardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyBoardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func backOP(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.blackNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        HUD.hide(animated: true)
//        self.blackNavBar()
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func keyBoardWillShow(_ note:Notification)
    {
        guard let userInfo  = (note as NSNotification).userInfo else { return }
        guard let window = UIApplication.shared.keyWindow else { return }
        let keyBoardBounds = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let deltaY = keyBoardBounds.size.height
        let currV = window.findFirstResponder()
        if let currV = currV as? UITextField{
            var p = self.view.convert(currV.zz_origin, from: currV.superview)
            if p.y > 0{
                p.y = -1*p.y
            }
            let animations:(() -> Void) = {
                self.view.transform = CGAffineTransform(translationX: 0,y: min((-deltaY+(self.view.frame.height + p.y - currV.frame.height - 20)),0))
            }
            if duration > 0 {
                let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
                UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)
            }else{
                animations()
            }
        }
    }
    
    func keyBoardWillHide(_ note:Notification)
    {
        let userInfo  = (note as NSNotification).userInfo
        let duration = (userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let animations:(() -> Void) = {
            self.view.transform = CGAffineTransform.identity
        }
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)
        }else{
            animations()
        }
    }
}


extension BlackVC:UIGestureRecognizerDelegate{
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.navigationController?.viewControllers.count == 1{
            return false
        }else{
            return true
        }
    }
    
}
