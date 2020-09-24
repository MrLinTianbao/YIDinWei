//
//  GlobalManager.swift
//  XLCustomer
//
//  Created by longma on 2019/1/3.
//  Copyright © 2019年 XLH. All rights reserved.
//

import UIKit

class MJManager: NSObject {
    //MARK: ********************************************************  其他
    

    
    /**
     生成随机字符串,
     
     - parameter length: 生成的字符串的长度
     
     - returns: 随机生成的字符串
     */
    class func getRandomString(withlength length: Int) -> String {
        let characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var ranStr = ""
        for _ in 0..<length {
            let index = Int(arc4random_uniform(UInt32(characters.count)))
            ranStr.append(characters[characters.index(characters.startIndex, offsetBy: index)])
        }
       
        return ranStr
        
    }
    
   
    /// 获取APP 版本
    ///
    /// - Returns: 版本号
    class func mj_appVersion() -> String {
        let infoDic = Bundle.main.infoDictionary
        if let appVersion = infoDic?["CFBundleShortVersionString"] as? String{
            return appVersion
        }
        return "1.0"
    }
    
   /// 普通的获取UUID的方法
    class func getUUID() -> String {
        let uuid = NSUUID().uuidString
        let strUrl = uuid.replacingOccurrences(of: "-", with: "")
        return strUrl
    }
    
  
    //MARK: ********************************************************  UI
    
    
    
    //MARK: ********************************************************  控制器
    // MARK: - 查找顶层控制器、
    // 获取顶层控制器 根据window
    @objc class func getTopVC() -> (UIViewController?) {
        var window = UIApplication.shared.keyWindow
        //是否为当前显示的window
        if window?.windowLevel != UIWindow.Level.normal{
            let windows = UIApplication.shared.windows
            for  windowTemp in windows{
                if windowTemp.windowLevel == UIWindow.Level.normal{
                    window = windowTemp
                    break
                }
            }
        }
        let vc = window?.rootViewController
        return getTopVC(withCurrentVC: vc)
    }
    ///根据控制器获取 顶层控制器
   class func getTopVC(withCurrentVC VC :UIViewController?) -> UIViewController? {
        if VC == nil {
            print("🌶： 找不到顶层控制器")
            return nil
        }
        if let presentVC = VC?.presentedViewController {
            //modal出来的 控制器
            return getTopVC(withCurrentVC: presentVC)
        }else if let tabVC = VC as? UITabBarController {
            // tabBar 的跟控制器
            if let selectVC = tabVC.selectedViewController {
                return getTopVC(withCurrentVC: selectVC)
            }
            return nil
        } else if let naiVC = VC as? UINavigationController {
            // 控制器是 nav
            return getTopVC(withCurrentVC:naiVC.visibleViewController)
        } else {
            // 返回顶控制器
            return VC
        }
    }
    
    /// 语言
    @objc class func OCLocalized(text:String) -> String {
        return text.localized()
    }
    
}
//MARK: ********************************************************  OC 调用方法
extension MJManager {
    /// 状态栏高度 + 导航栏高度
    @objc class func OCStatusBarAddNavBarHeight() -> CGFloat {
        return StatusBarHeight + NAVBarHeight
    }
    
    /// 屏幕宽度
    @objc class func OCScreenW() -> CGFloat {
        return ScreenW
    }
    
    /// 屏幕高度
    @objc class func OCScreenH() -> CGFloat {
        return ScreenH
    }
    /// 状态栏高度
    @objc class func OCStatusBarHeight() -> CGFloat {
        return StatusBarHeight
    }
    /// 导航栏高度
    @objc class func OCNAVBarHeight() -> CGFloat {
        return NAVBarHeight
    }

}


