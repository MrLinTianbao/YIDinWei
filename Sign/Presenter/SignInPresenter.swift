//
//  SignInPresenter.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/13.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit
import SwiftyJSON

class SignInPresenter: XWObject {

    //MARK: 发送验证码
    static func sendSMSCode(parameters : [String:Any]?,success :(() -> Void)?) {
        
        NetworkRequest.requestMethod(.post, URLString: url_sendSms, parameters: parameters, success: { (value, json) in
            
            success?()
            
        }) {
            
            
            
        }
        
    }
    
    //MARK: 获取用户信息
    static func getUserNews(success :((JSON) -> Void)?=nil ,failure:(() -> Void)?=nil) {
        
        if !isLogin {
            return
        }
        
        NetworkRequest.requestMethod(.get, URLString: url_info, parameters: nil, success: { (value, json) in
            
            CacheClass.setObject(json["data"]["id"].stringValue, forEnumKey: .id)
            CacheClass.setObject(json["data"]["amount"].stringValue, forEnumKey: .amount)
            CacheClass.setObject(json["data"]["phone"].stringValue, forEnumKey: .phone)
            CacheClass.setObject(json["data"]["nickname"].stringValue, forEnumKey: .nickname)
            CacheClass.setObject(json["data"]["avatar"].stringValue, forEnumKey: .avatar)
            CacheClass.setObject(json["data"]["total_amount"].stringValue, forEnumKey: .total_amount)
            CacheClass.setObject(json["data"]["used_amount"].stringValue, forEnumKey: .used_amount)
            CacheClass.setObject(json["data"]["linkId"].stringValue, forEnumKey: .linkId)
            CacheClass.setObject(json["data"]["is_vip"].stringValue, forEnumKey: .is_vip)
            CacheClass.setObject(json["data"]["userName"].stringValue, forEnumKey: .userName)
            CacheClass.setObject(json["data"]["password"].stringValue, forEnumKey: .password)
            CacheClass.setObject(json["data"]["vip_end"].stringValue, forEnumKey: .vip_end)
            CacheClass.setObject(json["authtoken"].stringValue, forEnumKey: .authtoken)
            
            success?(json)
            
        }) {
            
            failure?()
            
        }
        
    }
    
    //MARK: 登录
    static func signInAction(parameters : [String:Any]?,success :(() -> Void)?) {
        
        NetworkRequest.requestMethod(.post, URLString: url_login, parameters: parameters, success: { (value, json) in
            
            if json["msg"].stringValue != "" {
                
                AlertClass.stop()
                AlertClass.showToat(withStatus: json["msg"].stringValue)
                return
            }
            
            CacheClass.setObject(json["data"]["id"].stringValue, forEnumKey: .id)
            CacheClass.setObject(json["data"]["amount"].stringValue, forEnumKey: .amount)
            CacheClass.setObject(json["data"]["phone"].stringValue, forEnumKey: .phone)
            CacheClass.setObject(json["data"]["nickname"].stringValue, forEnumKey: .nickname)
            CacheClass.setObject(json["data"]["avatar"].stringValue, forEnumKey: .avatar)
            CacheClass.setObject(json["data"]["total_amount"].stringValue, forEnumKey: .total_amount)
            CacheClass.setObject(json["data"]["used_amount"].stringValue, forEnumKey: .used_amount)
            CacheClass.setObject(json["data"]["linkId"].stringValue, forEnumKey: .linkId)
            CacheClass.setObject(json["data"]["is_vip"].stringValue, forEnumKey: .is_vip)
            CacheClass.setObject(json["data"]["userName"].stringValue, forEnumKey: .userName)
            CacheClass.setObject(json["data"]["password"].stringValue, forEnumKey: .password)
            CacheClass.setObject(json["data"]["vip_end"].stringValue, forEnumKey: .vip_end)
            CacheClass.setObject(json["authtoken"].stringValue, forEnumKey: .authtoken)
            
            success?()
            
        }) {
            
            
        }
        
    }
    
    //MARK: 退出登录
    static func signOutAction() {
        
        CacheClass.removeObjectForEnumKey(.id)
        CacheClass.removeObjectForEnumKey(.amount)
        CacheClass.removeObjectForEnumKey(.phone)
        CacheClass.removeObjectForEnumKey(.nickname)
        CacheClass.removeObjectForEnumKey(.avatar)
        CacheClass.removeObjectForEnumKey(.total_amount)
        CacheClass.removeObjectForEnumKey(.used_amount)
        CacheClass.removeObjectForEnumKey(.linkId)
        CacheClass.removeObjectForEnumKey(.is_vip)
        CacheClass.removeObjectForEnumKey(.userName)
        CacheClass.removeObjectForEnumKey(.password)
        CacheClass.removeObjectForEnumKey(.vip_end)
        CacheClass.removeObjectForEnumKey(.authtoken)
        
        
        
    }
    
    //MARK: 设置字体样式
    static func setFontStyle() -> NSAttributedString {
        
        let string = aboutsignInTip.xw_changeLineForString(lineSpace: 5)
        
        let str = NSMutableAttributedString.init(attributedString: string)
        let range = (aboutsignInTip as NSString).range(of: privacyAgreement)
        let range2 = (aboutsignInTip as NSString).range(of: userProtocol)
        
        //添加超链接
        str.addAttribute(NSAttributedString.Key.link, value: "privacy://", range: range)
        str.addAttribute(NSAttributedString.Key.link, value: "user://", range: range2)
        
        return str
        
    }
}
