//
//  CacheEnum.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/7/28.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import Foundation


enum UDObject : String {
    
    case deviceId
    case authtoken
    case id
    case amount
    case phone
    case nickname
    case avatar
    case total_amount
    case used_amount
    case linkId
    case is_vip
    case userName
    case password
    case vip_end
    
}

struct UserInfo {
    
    static var deviceId : String {
        return CacheClass.stringForEnumKey(.deviceId) ?? ""
    }
    
    static var id : String {
        return CacheClass.stringForEnumKey(.id) ?? ""
    }
    
    static var authtoken : String {
        return CacheClass.stringForEnumKey(.authtoken) ?? ""
    }
    
    static var amount : String {
        return CacheClass.stringForEnumKey(.amount) ?? ""
    }
    
    static var phone : String {
        return CacheClass.stringForEnumKey(.phone) ?? ""
    }
    
    static var nickname : String {
        return CacheClass.stringForEnumKey(.nickname) ?? ""
    }
    
    static var avatar : String {
        return CacheClass.stringForEnumKey(.avatar) ?? ""
    }
    
    static var total_amount : String {
        return CacheClass.stringForEnumKey(.total_amount) ?? ""
    }
    
    static var used_amount : String {
        return CacheClass.stringForEnumKey(.used_amount) ?? ""
    }
    
    static var linkId : String {
        return CacheClass.stringForEnumKey(.linkId) ?? ""
    }
    
    static var is_vip : String {
        return CacheClass.stringForEnumKey(.is_vip) ?? ""
    }
    
    static var userName : String {
        return CacheClass.stringForEnumKey(.userName) ?? ""
    }
    
    static var password : String {
        return CacheClass.stringForEnumKey(.password) ?? ""
    }
    
    static var vip_end : String {
        return CacheClass.stringForEnumKey(.vip_end) ?? ""
    }
    
    
}


var isLogin : Bool {
    return UserInfo.authtoken != ""
}
