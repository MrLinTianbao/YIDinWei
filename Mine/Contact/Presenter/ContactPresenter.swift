//
//  ContactPresenter.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/17.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit
import SwiftyJSON

class ContactPresenter: NSObject {

    //MARK: 获取联系人列表
    static func getContactList(parameters:[String:Any]?,success :(([ContactModel]) -> Void)?,failure:(() -> Void)?) {
        
        NetworkRequest.requestMethod(.post, URLString: url_friends, parameters: parameters, success: { (value, json) in
            
            var dataArray = [ContactModel]()
            
            if let array = json["data"]["friendList"].arrayObject as? [[String:Any]] {
                
                for item in array {
                    let model = ContactModel.setModel(with: item)
                    dataArray.append(model)
                }
                
            }
            
            success?(dataArray)
            
            
            
        }) {
            
            failure?()
            
        }
        
    }
    
    //MARK: 删除联系人
    static func deleteContact(parameters:[String:Any]?,success :(() -> Void)?) {
        
        AlertClass.waiting(isDelete)
        
        NetworkRequest.requestMethod(.post, URLString: url_del, parameters: parameters, success: { (value, json) in
            
            AlertClass.stop()
            success?()
            
        }) {
            
            
            
        }
        
    }
    
}
