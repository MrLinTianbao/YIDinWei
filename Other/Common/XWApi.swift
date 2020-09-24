//
//  XWApi.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/7/28.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import Foundation

var urlStr : String {
    #if DEBUG
    return "http://pos.yuexinxs.com"
    #else
    return "https://pos.uksdvip.com"
    #endif
    
}

//MARK: 用户详情
var url_info = urlStr + "/api/crypto/client/user/info"
//MARK: 用户登录
var url_login = urlStr + "/api/crypto/client/user/login"
//MARK: 支付产品列表
var url_payList = urlStr + "/api/crypto/client/pay/list"
//MARK: 发起支付
var url_pay = urlStr + "/api/crypto/client/pay/pay"
//MARK: 发送短信验证码
var url_sendSms = urlStr + "/api/crypto/client/user/sendSms"
//MARK: 找回密码
var url_passwordByPhone = urlStr + "/api/crypto/client/user/passwordByPhone"
//MARK: 修改密码
var url_password = urlStr + "/api/crypto/client/user/password"
//MARK: 投诉反馈
var url_complaint = urlStr + "/api/crypto/client/user/complaint"
//MARK: 获取用户位置
var url_pos = urlStr + "/api/crypto/client/user/pos"
//MARK: 获取用户位置列表
var url_poss = urlStr + "/api/crypto/client/user/poss"
//MARK: 获取用户好友列表
var url_friends = urlStr + "/api/crypto/client/user/friends"
//MARK: 添加好友
var url_add = urlStr + "/api/crypto/client/user/add"
//MARK: 上传位置
var url_uploadPos = urlStr + "/api/crypto/client/user/uploadPos"
//MARK: 删除好友
var url_del = urlStr + "/api/crypto/client/user/del"
//MARK: 一键报警
var url_alarm = urlStr + "/api/crypto/client/user/alarm"
//MARK: 充值查询
var url_list = urlStr + "/api/crypto/admin/pay/list"
//MARK: 充值查询导出
var url_excel = urlStr + "/api/crypto/admin/pay/excel"
//MARK: 充值退款
var url_refund = urlStr + "/api/crypto/admin/pay/refund"
//MARK: 消息列表
var url_msgs = urlStr + "/api/crypto/client/user/msgs"
//MARK: 消息已读
var url_msgRead = urlStr + "/api/crypto/client/user/msgRead"
//MARK: 未读消息数
var url_msgUnread = urlStr + "/api/crypto/client/user/msgUnread"
//MARK: 同意好友请求
var url_agree = urlStr + "/api/crypto/client/user/agree"
//MARK: 设置备注
var url_friendNickName = urlStr + "/api/crypto/client/user/friendNickName"

//MARK: 逆地理编码
var url_regeo = "https://restapi.amap.com/v3/geocode/regeo"
 
//MARK: 内购验证
let url_applePayCb = urlStr + "/api/crypto/client/pay/applePayCb"
//MARK: 检查微信支付状态
let url_wechatPayStatus = urlStr + "/api/crypto/client/pay/check"
