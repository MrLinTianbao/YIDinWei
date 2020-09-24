//
//  Data+Extend.swift
//  YueXinWenHua
//
//  Created by TiBo's Mac on 2020/5/26.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import Foundation


//MARK: Data
extension Data {
    
    //此方法用于处理推送获取的token
    var DTHexString: String {
        
        return NSData.init(data: self).description.replacingOccurrences(of: "<", with: "").replacingOccurrences(of: ">", with: "").replacingOccurrences(of: " ", with: "")
        
    }
    
}
