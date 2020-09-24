//
//  NSObject+Extend.swift
//  YueXinWenHua
//
//  Created by TiBo's Mac on 2020/5/26.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import Foundation
import UIKit
import YYModel

// MARK: - NSObject
extension NSObject {
    class func setModel(with dict:[String:Any]) -> Self {
        return self.yy_model(with: dict) ?? self.init()
    }
    
    /// 获取key 防止iOS13以上崩溃
    /// - Parameter name:
    func getIvar(name:String) ->Any? {
      guard let _var = class_getInstanceVariable(type(of:self), name)else{
                     return nil
             }
             return object_getIvar(self, _var)
      }
}
