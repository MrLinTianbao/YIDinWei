//
//  AlarmPresenter.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/14.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit
import SwiftyJSON

class AlarmPresenter: NSObject {

    //MARK: 获取图片高度
    static func getImageHeight(image:UIImage,imageW:CGFloat?=ScreenW) -> CGFloat {
        
        return image.size.height*imageW!/image.size.width
        
    }
    
    //MARK: 发送信号
    static func sendSignal() {
        
        NetworkRequest.requestMethod(.get, URLString: url_alarm, parameters: nil, success: { (value, json) in
            
            AlertClass.showToat(withStatus: sendSuccess)
            
        }) {
            
            
            
        }
        
    }
    
    //MARK: 通讯录手机号转换纯数字
    static func phoneNumberFormat(phoneNum:String) -> String {
        
        do {
            let regular = try NSRegularExpression.init(pattern: "[^\\d]", options: NSRegularExpression.Options(rawValue: 0))
            let number = regular.stringByReplacingMatches(in: phoneNum, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, phoneNum.count), withTemplate: "")
            return number
        }catch{
            MyLog(error.localizedDescription)
        }
        
        return ""
        
    }
    
    //MARK: 添加紧急联系人
    static func addFriend(parameters:[String:Any]?,success :(() -> Void)?=nil) {
        
        NetworkRequest.requestMethod(.post, URLString: url_add, parameters: parameters, success: { (value, json) in
            
            AlertClass.stop()
            AlertClass.showToat(withStatus: addSuccess)
            
            if success != nil {
                success?()
            }
            
        }) {
            
            
            
        }
        
    }
    
}
