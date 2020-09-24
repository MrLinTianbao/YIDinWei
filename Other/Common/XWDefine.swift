//
//  XWDefine.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/7/28.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import Foundation
import UIKit

let appId = "3"
let appRId = "1"
let linkId = "2"
let pushId = "1"

let geoAppKey = "557dd81ef314df7a012073769c38bb18"
let wechatAppKey = "wxac780f84a5667fdf"
let universalLink = "https://h5ios.uksdvip.com"
let geoWebKey = "fcc34c669a1efc761373ce6de0b912b3"
let pushKey = "5856c4ef4cf77c8a9dfd4b42"
let downLoadUrl = "https://apps.apple.com/us/app/id1528304531" //下载链接

//MARK: app信息
struct AppInfo {
    
    static let infoDictionary = Bundle.main.infoDictionary
    
    static let appDisplayName: String = Bundle.main.infoDictionary!["CFBundleName"] as! String //App 名称
    
    static let bundleIdentifier:String = Bundle.main.bundleIdentifier! // Bundle Identifier
    
    static let appVersion:String = Bundle.main.infoDictionary! ["CFBundleShortVersionString"] as! String// App 版本号
    
    static let buildVersion : String = Bundle.main.infoDictionary! ["CFBundleVersion"] as! String //Bulid 版本号
    
    static let iOSVersion:String = UIDevice.current.systemVersion //ios 版本
    
    static let identifierNumber = UIDevice.current.identifierForVendor //设备 udid
    
    static let systemName = UIDevice.current.systemName //设备名称
    
    static let model = UIDevice.current.model // 设备型号
    
    static let localizedModel = UIDevice.current.localizedModel  //设备区域化型号

}

/// 状态栏高度
var StatusBarHeight : CGFloat {
    return UIApplication.shared.statusBarFrame.size.height
}

/// 导航栏高度
var NAVBarHeight : CGFloat {
    return UINavigationController().navigationBar.bounds.size.height
}

/// 状态栏高度 + 导航栏高度
var StatusBarAddNavBarHeight : CGFloat {
    return StatusBarHeight + NAVBarHeight
}

var TabBarHeight : CGFloat {
    return UITabBarController().tabBar.bounds.size.height
}

///像素
var Scale : CGFloat {
    return UIScreen.main.scale
}

/// 屏幕宽度
var ScreenW : CGFloat {
    return UIScreen.main.bounds.size.width
}

/// 屏幕高度
var ScreenH : CGFloat {
    return UIScreen.main.bounds.size.height
}

//MARK: 长度适配(以iPhone7为例)
func RATIO(_ num:CGFloat) -> CGFloat {
    return num * ((UIScreen.main.bounds.size.width) / 375.0)
}

func RATIO_H(_ num:CGFloat) -> CGFloat {
    return num * ((UIScreen.main.bounds.size.height) / 667.0)
}

func RATIO(maxNum:CGFloat) -> CGFloat {
    let a = maxNum * ((UIScreen.main.bounds.size.width) / 375.0)
    return a > maxNum ? maxNum : a
}

func RATIO_H(maxNum:CGFloat) -> CGFloat {
    let a = maxNum * ((UIScreen.main.bounds.size.height) / 667.0)
    return a > maxNum ? maxNum : a
}
func RATIO(minNum:CGFloat) -> CGFloat {
    let a = minNum * ((UIScreen.main.bounds.size.width) / 375.0)
    return a > minNum ? a : minNum
}
// MARK: - 打印方法
func MyLog<T>(_ message : T,file:String = #file,methodName: String = #function, lineNumber: Int = #line){
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    let dateForm = DateFormatter.init()
    dateForm.dateFormat = "HH:mm:ss:SSS"
    print("[\(fileName)][\(lineNumber)][\(dateForm.string(from: Date()))]\(methodName):\(message)")
    #endif
    
}
