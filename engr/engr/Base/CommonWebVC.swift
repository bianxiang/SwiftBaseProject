//
//  CommonWebVC.swift
//  zuber
//
//  Created by duzhe on 15/11/25.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit
import WebKit
import PKHUD

//@objc protocol CommonWebVCDelegate{
//    @objc optional func doubanOAuthSuccess(_ code:String)   
//}

//class CommonWebVC: BlackVC , WKNavigationDelegate{
//    var urlString:String?
//    var url:URL?
//    var isDouban = false

//    fileprivate var webView:WKWebView!
//    fileprivate var progressView:UIProgressView!
//    fileprivate var hostLabel:UILabel! // 用于显示网页来源
//    weak var delegate:CommonWebVCDelegate?
//    
//    override func viewDidLoad(){
//        super.viewDidLoad()
//        
//        webView = WKWebView()
//        if let desiredURL = urlString
//        {
//            if let url = URL(string: desiredURL){
//                webView.load(URLRequest(url: url))
//                self.view.addSubview(webView)
//            }
//        }else{
//            if let url = self.url{
//                webView.load(URLRequest(url: url))
//                self.view.addSubview(webView)
//            }
//        }
//        webView.navigationDelegate = self
//        webView.snp.makeConstraints { (make) -> Void in
//            make.top.equalTo(self.view)
//            make.left.right.bottom.equalTo(self.view)
//        }
//        
//        
//        hostLabel = UILabel()
//        webView.scrollView.insertSubview(hostLabel, at: 0)
//        hostLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(self.view).offset(74)
//            make.left.right.equalTo(self.view)
//        }
//        hostLabel.textAlignment = .center
//        hostLabel.textColor = UIColor.REMIND_COLOR
//        hostLabel.font = UIFont.systemFont(ofSize: 13)
//        hostLabel.text = ""
//        hostLabel.isHidden = true
//        
//        progressView = UIProgressView()
//        progressView.trackTintColor = UIColor.white
//        progressView.progressTintColor = UIColor.MAIN_COLOR
//        self.view.addSubview(progressView)
//        progressView.snp.makeConstraints { (make) in
//            make.top.equalTo(self.view).offset(64)
//            make.left.right.equalTo(self.view)
//            make.height.equalTo(3)
//        }
//        
//        webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
//        webView.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.new, context: nil)
//        self.view.backgroundColor = UIColor.white
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//    }
//    
//    deinit{
//        webView.removeObserver(self, forKeyPath: "estimatedProgress")
//        webView.removeObserver(self, forKeyPath: "title")
//    }
//    
//    func back(){
//        self.navigationController?.popViewController(animated: true)
//    }
//    
//    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if keyPath == "estimatedProgress"{
//            self.progressView.alpha = 1
//            self.progressView.setProgress(Float(self.webView.estimatedProgress), animated: true)
//            if self.webView.estimatedProgress>=1{
//                UIView.animate(withDuration: 0.3, animations: { 
//                        self.progressView.alpha = 0
//                    }, completion: { b in
//                        self.progressView.alpha = 0
//                })
//            }
//        }else if keyPath == "title"{
//            if let host = self.webView.url?.host{
//                hostLabel.text = "网页由 \(host) 提供"
//            }else{
//                hostLabel.text = "未知的网页来源"
//            }
//            self.title = self.webView.title
//        }
//    }
//    
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        hostLabel.isHidden = false
//    }
//    
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        if isDouban{
//            guard let targetUrl = navigationAction.request.url?.absoluteString else {
//                return
//            }
//            // let register = "https://www.douban.com/accounts/register" // 注册
//            if targetUrl == "\(__$.dbCallBack)?error=access_denied"{
//                // 用户拒绝了授权
//                HUD.flash(.label("您拒绝了授权"), delay: __$.WAITTING_SECONDS)
//                self.navigationController?.popViewController(animated: true)
//                decisionHandler(WKNavigationActionPolicy.cancel) // 这句必须有
//                return
//                
//            }else if targetUrl.hasPrefix("\(__$.dbCallBack)?code="){
//                // 授权成功
//                let tmpUrl = targetUrl.replace("\(__$.dbCallBack)?code=", new: "")
//                let code = tmpUrl.split("&")[0]
//                // - 使用code授权登录
//                delegate?.doubanOAuthSuccess?(code)
//                decisionHandler(WKNavigationActionPolicy.cancel)
//                return
//            }
//        }
//        decisionHandler(WKNavigationActionPolicy.allow)
//    }
//
//}
