//
//  XWTool.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/7/28.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import Foundation
import UIKit

//MARK: 获取当前时间
func getCurrentTime() -> String {
    
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
    
    return dateFormatter.string(from: date)
}


//MARK: 是否是新机型
var isIPhoneX: Bool {
    if UIScreen.main.bounds.height > 736 {
        return true
    } else {
        return false
    }
}



//MARK: 数据解码
func decryptionAction(data:String,key:String?="6839724510") -> String {
    
    let keyList =  key!.map{ $0 }
    
    var list = [Int]()
    
    for item in keyList {
        
        list.append(Int(String(item))!)
    }
    
    var residue = data.count%list.count
    
    let enLength = data.count - residue
    
    var keyList1 = [Int]()
    
    for item in list {
        
        if item < residue {
            keyList1.append(item)
        }
    }
    
    var chars = [String]()
    
    for _ in 0..<data.count {
        chars.append("")
    }
    
    var index = 0
    
    let data2 = data.map{ $0 }
    
    for i in 0..<data.count {
        if i < enLength {
            residue = i % list.count
            index = i - residue + list[residue]
            chars[index] = String(data2[i])
        }else{
            residue = i % list.count%keyList1.count
            index = i - residue + keyList1[residue]
            chars[index] = String(data2[i])
        }
    
    }
    
    let str = chars.joined(separator: "")
    
    return YXTool_OC.unesp(str)
    
    
}

//MARK: 获取设备ID
func getDeviceId() {
    
    var deviceId = SAMKeychain.password(forService: AppInfo.bundleIdentifier, account: "user")
    if deviceId == nil {
        
        let uuid = NSUUID().uuidString
        SAMKeychain.setPassword(uuid, forService: AppInfo.bundleIdentifier, account: "user")
        deviceId = SAMKeychain.password(forService: AppInfo.bundleIdentifier, account: "user")
    }
    
    CacheClass.setObject(deviceId, forEnumKey: .deviceId)
}

