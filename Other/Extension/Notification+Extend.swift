//
//  Notification+Extend.swift
//  YueXinWenHua
//
//  Created by TiBo's Mac on 2020/5/26.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    /// 刷新用户信息
    static public let updateUserNew = Notification.Name(rawValue: "updateUserNew")
    /// 更新好友列表
    static public let updateFriendList = Notification.Name(rawValue: "updateFriendList")
    /// 设置消息已读
    static public let setReadMsg = Notification.Name(rawValue: "setReadMsg")
    /// 获取未读消息
    static public let getUnreadMsg = Notification.Name(rawValue: "getUnreadMsg")
    /// 检查支付状态
    static public let checkPayStatus = Notification.Name(rawValue: "checkPayStatus")
    /// 推送
    static public let apnsPush = Notification.Name(rawValue: "apnsPush")
    
}

