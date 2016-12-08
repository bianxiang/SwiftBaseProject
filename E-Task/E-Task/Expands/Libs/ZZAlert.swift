//
//  ZZAlert.swift
//  zuber
//
//  Created by duzhe on 15/12/20.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

struct ZZAlert {

    static func showAlert(_ controller:UIViewController,meg:String,btn1:String?,btn2:String?,handler:@escaping ((UIAlertAction) -> Void)){
        let vc = controller
        DispatchQueue.main.async(execute: { () -> Void in
            let alertController = UIAlertController(title:"提示",
                message:meg ,
                preferredStyle: .alert)
            if btn1 != nil{
                let cancelAction = UIAlertAction(title:btn1, style: .cancel, handler:nil)
                
                alertController.addAction(cancelAction)
            }
           
            
            if btn2 != nil{
                let settingsAction = UIAlertAction(title: btn2, style: .default, handler: { (action) -> Void in
                    handler(action)
                })
                alertController.addAction(settingsAction)
            }
            vc.present(alertController, animated: true, completion: nil)
        })
    }
    
    static func showAlert(_ controller:UIViewController,title:String,meg:String,btn1:String?,btn2:String?,handler:@escaping ((UIAlertAction) -> Void)){
        let vc = controller
        DispatchQueue.main.async(execute: { () -> Void in
            let alertController = UIAlertController(title:title,
                message:meg ,
                preferredStyle: .alert)
            if btn1 != nil{
                let cancelAction = UIAlertAction(title:btn1, style: .cancel, handler:nil)
                
                alertController.addAction(cancelAction)
            }
            
            
            if btn2 != nil{
                let settingsAction = UIAlertAction(title: btn2, style: .default, handler: { (action) -> Void in
                    handler(action)
                })
                alertController.addAction(settingsAction)
            }
            vc.present(alertController, animated: true, completion: nil)
        })
    }
    
    static func showAlert(_ controller:UIViewController,meg:String,btn1:String?,btn2:String?,zid:String,handler:@escaping ((_ id:String) -> Void)){
        let vc = controller
        DispatchQueue.main.async(execute: { () -> Void in
            let alertController = UIAlertController(title:"提示",
                message:meg ,
                preferredStyle: .alert)
            if btn1 != nil{
                let cancelAction = UIAlertAction(title:btn1, style: .cancel, handler:nil)
                
                alertController.addAction(cancelAction)
            }
            
            
            if btn2 != nil{
                let settingsAction = UIAlertAction(title: btn2, style: .default, handler: { (action) -> Void in
                    handler(zid)
                })
                alertController.addAction(settingsAction)
            }
            vc.present(alertController, animated: true, completion: nil)
        })
    }
    
    static func showAlert(_ controller:UIViewController,title:String,meg:String,btn1:String,btn2:String?,handler1:((UIAlertAction) -> Void)?,handler2:((UIAlertAction) -> Void)?){
        let vc = controller
        DispatchQueue.main.async(execute: { () -> Void in
            let alertController = UIAlertController(title:title,
                message:meg ,
                preferredStyle: .alert)
            let action1 = UIAlertAction(title:btn1, style: .default, handler:handler1)
            
            alertController.addAction(action1)
            
            if btn2 != nil{
                let settingsAction = UIAlertAction(title: btn2, style: .default, handler: { (action) -> Void in
                    handler2?(action)
                })
                alertController.addAction(settingsAction)
            }
            
            vc.present(alertController, animated: true, completion: nil)
        })
    }

    
    static func showAlert(_ controller:UIViewController,meg:String){
        showAlert(controller, meg: meg, btn1: "确定", btn2: nil, handler: { _ in
            
        })
    }
    
    static func showAlert(_ controller:UIViewController,meg:String,handler:@escaping ((UIAlertAction) -> Void)){
        showAlert(controller, meg: meg, btn1: nil , btn2: "完成", handler: handler)
    }
    static func showAlert(_ controller:UIViewController,title:String,meg:String,handler:@escaping ((UIAlertAction) -> Void)){
        showAlert(controller,title:title,meg: meg,btn1: "确定",btn2: nil,handler1:handler,handler2:nil)
    }
    
    
    static func showAlertWithField(_ controller:UIViewController,title:String,meg:String,btn1:String?,btn2:String?,handler:@escaping ((_ txt:String?) -> Void)){
        let vc = controller
        let alertController = UIAlertController(title: title,
                                                message: meg, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "请输入拒绝理由"
        }
       
        let cancelAction = UIAlertAction(title: btn1, style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: btn2, style: .default,
                                     handler: {
                                        action in
                                        let txtField = alertController.textFields!.first! as UITextField
                                        handler(txtField.text)
                                        
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        vc.present(alertController, animated: true, completion: nil)
    }
}

