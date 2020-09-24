//
//  CachesClass.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/7/28.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import Foundation

class CacheClass: NSObject {
    
    // MARK: 往沙盒添加数据
    static func setObject(_ value: Any?, forKey defaultName: String) {
        UserDefaults.standard.set(value, forKey: defaultName)
        UserDefaults.standard.synchronize()
    }
    
    // MARK: - 添加沙盒数据
    static func setObject(_ value: Any?, forEnumKey defaultName: UDObject) {
        UserDefaults.standard.set(value, forKey: defaultName.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    // MARK: 从沙盒取数据
    static func objectForKey(_ defaultName: String) -> Any?{
        return UserDefaults.standard.object(forKey: defaultName)
    }
    
    // MARK: 读取沙盒数据
    static func stringForEnumKey(_ defaultName: UDObject) -> String?{
        return UserDefaults.standard.string(forKey: defaultName.rawValue)
    }
    static func intForEnumKey(_ defaultName: UDObject) -> Int?{
        return UserDefaults.standard.integer(forKey: defaultName.rawValue)
    }
    static func boolForEnumKey(_ defaultName: UDObject) -> Bool?{
        return UserDefaults.standard.bool(forKey: defaultName.rawValue)
    }
    
    static func arrayForEnumKey(_ defaultName: UDObject) -> [Any]?{
        //数组类型的key一般后加用户id
        return UserDefaults.standard.array(forKey: defaultName.rawValue)
    }
    
    static func stringArrayForEnumKey(_ defaultName:UDObject) -> [String]? {
        return UserDefaults.standard.stringArray(forKey: defaultName.rawValue)
    }
    
    static func dictionaryForEnumKey(_ defaultName: UDObject) -> [String : Any]?{
        return UserDefaults.standard.dictionary(forKey: defaultName.rawValue)
    }
    
    static func dataForEnumKey(_ defaultName: UDObject) -> Data?{
        return UserDefaults.standard.data(forKey: defaultName.rawValue)
    }
    
    //MARK: 移除沙盒数据
    static func removeObjectForKey(_ defaultName: String){
        UserDefaults.standard.removeObject(forKey: defaultName)
        UserDefaults.standard.synchronize()
    }
    
    //MARK: 移除沙盒数据
    static func removeObjectForEnumKey(_ defaultName: UDObject){
        UserDefaults.standard.removeObject(forKey: defaultName.rawValue)
        UserDefaults.standard.synchronize()
    }
}
