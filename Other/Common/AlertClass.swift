//
//  AlertClass.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/7/28.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh
import SVProgressHUD
import SwiftyJSON
import Toast

typealias WaitCompletion = () -> Void

let kViewAwaitTime:Double = 1.2//等待时间

class AlertClass: NSObject {

    // MARK: - 提醒操作
    // MARK: 只有一个按钮的提醒操作
    /// 只有一个按钮的提醒操作
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - msg: 提示信息
    ///   - target: 显示在哪个控制器上
    ///   - actionTitle: 动作按钮标题
    ///   - cancelTitle: 取消按钮标题
    ///   - haveCancel: 是否有取消按钮
    ///   - handler: 点击确定后的操作
    @objc static func setAlertView(title:String? = global_systemAlert,msg:String? , target:UIViewController? ,actionTitle:String? = global_confirm,cancelTitle:String? = global_cancel,haveCancel:Bool , handler:((UIAlertAction) -> Void)?) {
        let alertView = UIAlertController.init(title: title, message: msg, preferredStyle: .alert)
        
        let enterAction = UIAlertAction.init(title: actionTitle, style: .default) { (alertView) in
            handler?(alertView)
        }
        
        if haveCancel {
            let cancelAction = UIAlertAction.init(title: cancelTitle, style: .cancel, handler: nil)
            alertView.addAction(cancelAction)
        }
        alertView.addAction(enterAction)
        target?.present(alertView, animated: true, completion: nil)
        
    }
    
    // MARK: - 提醒操作
    /// - Parameters:
    ///   - title: 标题
    ///   - msg: 提示信息
    ///   - target: 显示在哪个控制器上
    ///   - actionTitle: 动作按钮标题
    ///   - cancelTitle: 取消按钮标题
    ///   - handler: 点击确定后的操作
    @objc static func setBottomAlertView(title:String? = global_systemAlert,msg:String? , target:UIViewController? ,actionTitle:[String],cancelTitle:String? = global_cancel,handler:((UIAlertAction) -> Void)?) {
        
        let alertView = UIAlertController.init(title: title, message: msg, preferredStyle: .actionSheet)
        
        for i in 0..<actionTitle.count {
            
            let action = UIAlertAction.init(title: actionTitle[i], style: .default) { (alert) in
                handler?(alert)
            }
            
            alertView.addAction(action)
        }
        
        
        let cancelAction = UIAlertAction.init(title: global_cancel, style: .cancel) { (alert) in
            
            handler?(alert)
        }
        
        alertView.addAction(cancelAction)
        
        target?.present(alertView, animated: true, completion: nil)
    }
    
    // MARK: - 设置刷新
    static func setRefresh(with scrollView :UIScrollView ,headerAction : (()->Void)? , footerAction : (()->Void)? ) {
        
        //下拉刷新
        let header = MJRefreshNormalHeader.init(refreshingBlock: headerAction!)
        scrollView.mj_header = header
        
        
        if footerAction == nil {
            return
        }
        
        
        //上拉加载
        let footer =  MJRefreshBackNormalFooter.init(refreshingBlock: footerAction!)
        scrollView.mj_footer = footer
        
        footer.loadingView?.style = .gray //activityIndicatorViewStyle = .gray
        footer.stateLabel?.textColor = .gray
        
    }
    
    
    // MARK: - 蒙版加载工具
    /// 显示加载动画
    ///
    /// - Parameter text: 加载文字提示
    static func waiting(_ text:String = loading) {
        
        MBProgressHUD_XW.showMessage(message: text, toView: nil)
    }
    
    /// 停止加载动画
    static func stop() {
        
        MBProgressHUD_XW.hide(forView: nil, animated: true)
    }
    class func show(_ text:String = "") {
        
        MBProgressHUD_XW.showMessage(message: text, toView: nil)
    }
    class func showErrorToat(withJson json: JSON) {
        if let error = json["error"].string {
            self.showToat(withStatus: error)
        }
    }
    class func showMessageToat(withJson json: JSON) {
        if let message = json["message"].string {
            self.showToat(withStatus: message)
        }
    }
    class func showMessageToat(withJson json: JSON,completion: @escaping WaitCompletion) {
        
        if let message = json["message"].string {
            self.showToat(withStatus: message)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(kViewAwaitTime * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            completion()
        })
    }
    @objc class func showToat(withStatus status: String?) {
        
        let topVC: UIViewController? = MJManager.getTopVC()
        MBProgressHUD_XW.show(text: status ?? "", view: topVC?.view)
        
        
        
//        // create a new style
//        let style = CSToastStyle.init(defaultStyle: ())
//        // this is just one of many style options
//        style?.messageColor = UIColor.white
//        style?.messageFont = UIFont.systemFont(ofSize: 15)
//        style?.messageAlignment = .center
//        style?.cornerRadius = 3
//        style?.verticalPadding = 10
//
//        // present the toast with the new style
//        let topVC: UIViewController? = MJManager.getTopVC()
//        topVC?.view.makeToast(status, duration: 2.0, position: NSValue(cgPoint: CGPoint(x: ScreenW / 2, y: ScreenH / 2 - 20)), style: style)
        
    }
    
    class func showToat(withStatus status: String? , completion: @escaping WaitCompletion) {
        // create a new style
        let style = CSToastStyle.init(defaultStyle: ())
        // this is just one of many style options
        style?.messageColor = UIColor.white
        style?.messageFont = UIFont.systemFont(ofSize: 15)
        style?.messageAlignment = .center
        style?.cornerRadius = 3
        style?.verticalPadding = 10
        
        // present the toast with the new style
        let topVC: UIViewController? = MJManager.getTopVC()
        topVC?.view.makeToast(status, duration: 2.0, position: NSValue(cgPoint: CGPoint(x: ScreenW / 2, y: ScreenH / 2 - 20)), style: style)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(kViewAwaitTime * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            completion()
        })
    }
    
    
}
