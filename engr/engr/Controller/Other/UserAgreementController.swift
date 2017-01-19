//
//  UserAgreementController.swift
//  FindWork
//
//  Created by bianxiang on 16/11/18.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import UIKit

class UserAgreementController: BlackVC {
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        self.title = "用户协议"
//        zp(_g.metadata?.registerArg)
//        if let url =  URL(string: (_g.metadata?.registerArg)!){
//            webView.loadRequest(URLRequest(url: url))
//        }
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
