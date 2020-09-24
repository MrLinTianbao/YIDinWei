//
//  HomePresenter.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/12.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomePresenter: XWObject {

    //MARK: 上传位置
    static func uploadLocation(parameters:[String:Any]?) {
        
        NetworkRequest.requestMethod(.post, URLString: url_uploadPos, parameters: parameters, success: { (value, json) in
            
            
            
        }) {
            
        }
    }
    
    //MARK: 获取用户位置
    static func getUserPods(parameters:[String:Any]?,success :(([HomeModel]) -> Void)? ,failure:(() -> Void)?) {
        
        NetworkRequest.requestMethod(.post, URLString: url_friends, parameters: parameters, success: { (value, json) in
            
            var dataArray = [HomeModel]()
            
            if let array = json["data"]["friendList"].arrayObject as? [[String:Any]] {
                
                for item in array {
                    let model = HomeModel.setModel(with: item)
                    dataArray.append(model)
                }
                
            }
            
            success?(dataArray)
            
        }) {
           
            failure?()
        }
    }
    
    //MARK: 逆地理编码
    static func getAddress(parameters:[String:Any]?,success :((JSON) -> Void)?) {
        
        NetworkRequest.requestMethod(.get, URLString: url_regeo, parameters: parameters
            , isEncryption: false, success: { (value, json) in
                
                success?(json)
                
        }) {
            
            
            
        }
        
    }
    
    //MARK: 设置好友备注
    static func setFriendNote(parameters:[String:Any]?,success :(() -> Void)?) {
        
        
        NetworkRequest.requestMethod(.post, URLString: url_friendNickName, parameters: parameters, success: { (value, json) in
            
            success?()
            
        }) {
            
            
            
        }
        
    }
    
    //MARK: 删除好友
    static func deleteFriend(parameters:[String:Any]?,success :(() -> Void)?) {
        
        NetworkRequest.requestMethod(.post, URLString: url_del, parameters: parameters, success: { (value, json) in
            
            success?()
            
        }) {
            
            
            
        }
        
    }
    
    //MARK: 获取未读消息
    static func getUnreadMsg(success :((String) -> Void)?) {
        
        NetworkRequest.requestMethod(.get, URLString: url_msgUnread, parameters: nil, success: { (value, json) in
            
            if let count = json["data"].int {
               success?(String(count))
            }
            
            
            
        }) {
            
            
        }
        
    }
    
    //MARK: 设置消息已读
    static func setReadMsg() {
        
        NetworkRequest.requestMethod(.post, URLString: url_msgRead, parameters: nil, success: { (value, json) in
            
            NotificationCenter.default.post(name: .setReadMsg, object: nil)
            
        }) {
            
            
            
        }
    }
    
    //MARK: 保留6位小数点
    static func saveDecimalPoint(digital:Double) -> String {
        
        return String(format: "%.6f", digital)
        
    }
    
}
