//
//  LocationPresenter.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/18.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class LocationPresenter: NSObject {

    //MARK: 获取用户位置列表
    static func getUserPossList(parameters:[String:Any]?,success :(([LocationModel]) -> Void)?) {
        
        NetworkRequest.requestMethod(.post, URLString: url_poss, parameters: parameters, success: { (value, json) in
            
            var dataArray = [LocationModel]()
            
            if let array = json["data"].arrayObject as? [[String:Any]] {
                
                for item in array {
                    let model = LocationModel.setModel(with: item)
                    dataArray.append(model)
                }
            }
            
            success?(dataArray)
            
        }) {
            
            
            
        }
        
    }
    
}
