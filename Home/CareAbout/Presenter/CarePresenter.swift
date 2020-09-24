//
//  CarePresenter.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/17.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit
import SwiftyJSON

class CarePresenter: NSObject {

    //MARK: 添加好友
    static func addFriendAction(parameters:[String:Any]?,success :((JSON) -> Void)?) {
        
        NetworkRequest.requestMethod(.post, URLString: url_add, parameters: parameters, success: { (value, json) in
            
            success?(json)
            
        }) {
            
            
            
        }
        
    }
    
    //MARK: 分享
    static func shareForFriend(json:JSON,type:Int32) {
        
        if let dic = json["data"].dictionaryObject {
            
            let model = ShareModel.setModel(with: dic)
            let webpageObject = WXWebpageObject()
            webpageObject.webpageUrl = model.url ?? ""
            let message = WXMediaMessage()
            message.title = model.title ?? ""
            message.description = model.des ?? ""
            message.setThumbImage(UIImage.init(data: try! Data.init(contentsOf: URL.init(string: model.img!)!))!)
            message.mediaObject = webpageObject
            let req = SendMessageToWXReq()
            req.bText = false
            req.message = message
            req.scene = type
            WXApi.send(req) { (flag) in
                
                
            }
        }
        
        
        
    }
    
    //MARK: 微信分享
    static func shareForWechat(type:Int32) {
        
        
            let webpageObject = WXWebpageObject()
            webpageObject.webpageUrl = downLoadUrl
            let message = WXMediaMessage()
            message.title = user + UserInfo.phone + inviteForFrined
            message.description = downLoadApp
            message.setThumbImage("WechatIMG566".getImage())
            message.mediaObject = webpageObject
            let req = SendMessageToWXReq()
            req.bText = false
            req.message = message
            req.scene = type
            WXApi.send(req) { (flag) in
                
                
            }
        
        
        
        
    }
    
}
