//
//  XWWebViewController.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/12.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit
import WebKit

class XWWebViewController: XWViewController {
    
    fileprivate var urlStr = "http://pos.yuexinxs.com/onlineservice.html"

    ///webview
    fileprivate var webView : WKWebView!
    
    ///进度条
    fileprivate let progressView = UIProgressView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = commonQuession
        
        progressView.trackTintColor = UIColor.clear
        progressView.progressTintColor = UIColor.red
        self.view.addSubview(progressView)
        
        progressView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(RATIO_H(maxNum: 2))
        }
        
        createWebView()
        
        self.view.bringSubviewToFront(progressView)

    }
    
    deinit {
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }

    fileprivate func createWebView() {
            
        self.webView = WKWebView.init(frame: .zero)
        
        if let url = URL.init(string: self.urlStr) {
            let request = URLRequest.init(url: url)
            webView.load(request)
        }
        webView.navigationDelegate = self
        webView.uiDelegate = self
        self.view.addSubview(webView)
       
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    
        
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
                
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if "estimatedProgress" == keyPath {
            self.progressView.setProgress(Float(self.webView.estimatedProgress), animated: true)
            if self.progressView.progress == 0 {
                self.progressView.isHidden = false
            }else if self.progressView.progress == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    if self.progressView.progress == 1 {
                        self.progressView.progress = 0
                        self.progressView.isHidden = true
                    }
                }
            }
        }
    }

}

extension XWWebViewController : WKNavigationDelegate,WKUIDelegate {
    
    //MARK: 页面加载失败
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        MyLog(global_requestFailed)
    }
    
    
    
    //MARK: 页面加载成功
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        MyLog(global_loadSuccess)
    }
    
}
