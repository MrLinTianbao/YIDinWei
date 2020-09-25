//
//  AppDelegate.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/7/28.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit
import SwiftyStoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //获取推送的内容
        if let remoteNotification = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] {

            CacheClass.setObject(remoteNotification, forKey: "pushOptions")
        }
        

        AMapServices.shared()?.apiKey = geoAppKey
        
//        WXApi.startLog(by: .detail) { (log) in
//            MyLog("WeChatSDK:\(log)")
//        }
        
        WXApi.registerApp(wechatAppKey, universalLink: universalLink)
        
//        WXApi.checkUniversalLinkReady { (step, result) in
//            MyLog("\(step),\(result.success),\(result.errorInfo),\(result.suggestion)")
//        }
        
        getDeviceId()
        SignInPresenter.getUserNews()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = XWTabBarController()
        window?.makeKeyAndVisible()
        
        setPurchasing()
        setPushSDK(launchOptions: launchOptions)
        
        if #available(iOS 11.0, *) {
            UITableView.appearance().estimatedRowHeight = 0
            UITableView.appearance().estimatedSectionFooterHeight = 0
            UITableView.appearance().estimatedSectionHeaderHeight = 0
        }
        
        
        return true
    }

    //MARK: 内购设置
    fileprivate func setPurchasing() {
        
        SwiftyStoreKit.completeTransactions(atomically: true) { (purchases) in
            
            for purchase in purchases {
            
                    if purchase.transaction.transactionState == .purchased || purchase.transaction.transactionState == .restored {
            
                       if purchase.needsFinishTransaction {
                           // Deliver content from server, then:
                           SwiftyStoreKit.finishTransaction(purchase.transaction)
                       }
                       MyLog("purchased: \(purchase)")
                    }
                }
            
        }

        
    }
    
    //MARK: 设置推送功能
    func setPushSDK(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
        let entity = JPUSHRegisterEntity()

        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.sound,.alert,.carPlay]) { (bool, error) in
                
                if bool {
                    MyLog("授权成功")
                }else{
                    MyLog("授权失败")
                }
            
            }
        } else {
            
            let notificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound],
                                                                  categories: nil)
            UIApplication.shared.registerUserNotificationSettings(notificationSettings)
            
        }
        
        
        #if DEBUG
        JPUSHService.setup(withOption: launchOptions, appKey: pushKey, channel: "", apsForProduction: false)
        #else
        JPUSHService.setup(withOption: launchOptions, appKey: pushKey, channel: "", apsForProduction: true)
        #endif
        
        
        JPUSHService.registrationIDCompletionHandler { (code, registrationID) in
            if code == 0 {
                MyLog("registrationID获取成功：\(String(describing: registrationID))")
                //101d855909c9aa5b1bc
            }else{
                MyLog("registrationID获取失败：\(code)")
            }


        }
        
    }
    
    //MARk: 提交deviceToken
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
    }
    
    //MARK: 获取token失败
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        MyLog(error.localizedDescription)
        
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        
        return WXApi.handleOpen(url, delegate: self)
    }


}

extension AppDelegate : WXApiDelegate {
    
    //是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用 sendRsp 返回。在调用 sendRsp 返回时，会切回到微信终端程序界面。
    func onReq(_ req: BaseReq) {
        
        
        
    }
    
    //如果第三方程序向微信发送了 sendReq 的请求，那么 onResp 会被回调。sendReq 请求调用后，会切到微信终端程序界面。
    func onResp(_ resp: BaseResp) {
        
        
        
    }
    
}

extension AppDelegate : JPUSHRegisterDelegate {
    
    //MARK: app前台收到通知
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        
        let userInfo = notification.request.content.userInfo
        
        if notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue))
    }
    
    //MARK: 用户点击推送进入app
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        
        let userInfo = response.notification.request.content.userInfo
        
        NotificationCenter.default.post(name: .apnsPush, object: nil, userInfo: userInfo)
        
        if response.notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler()
        
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification!) {
        
        if (notification != nil) && notification.request.trigger is UNPushNotificationTrigger {
            
            AlertClass.showToat(withStatus: "从通知界面直接进入应用")
            
        }else{
            AlertClass.showToat(withStatus: "从通知设置界面进入应用")
        }
        
    }
    
    //MARK: 用户通知授权状态
    func jpushNotificationAuthorization(_ status: JPAuthorizationStatus, withInfo info: [AnyHashable : Any]!) {
        
        
        JPUSHService.handleRemoteNotification(info)
    }
    
    
    
}
