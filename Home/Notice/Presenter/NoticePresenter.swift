//
//  NoticePresenter.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/17.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit
import SwiftyJSON

class NoticePresenter: NSObject {

    //MARK: 获取通知列表
    static func getNoticeList(parameters:[String:Any]?=nil,success :(([NoticeModel]) -> Void)? ,failure:(() -> Void)?) {
        
        NetworkRequest.requestMethod(.post, URLString: url_msgs, parameters: parameters, success: { (value, json) in
            
            var dataArray = [NoticeModel]()
            
            if let array = json["data"].arrayObject as? [[String:Any]] {
                
                for item in array {
                    let model = NoticeModel.setModel(with: item)
                    dataArray.append(model)
                }
                
            }
            
            success?(dataArray)
            
        }) {
            
            
            
        }
        
    }
    
    //MARK: 同意好友请求
    static func agreeFriendAction(parameters:[String:Any]?,success :(() -> Void)?) {
        
        NetworkRequest.requestMethod(.post, URLString: url_agree, parameters: parameters, success: { (value, json) in
            
            success?()
            
        }) {
            
            
            
        }
        
    }
    
}
