//
//  MineHeadView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/7.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class MineHeadView: XWView {
    
    fileprivate let bgView = XWImageView()
    
    let setbutton = XWButton()
    let headImageView = XWButton()
    let phoneLabel = XWButton()
    let nickNameLabel = XWButton()
    
    fileprivate let renewalView = XWView()
    fileprivate let unlockLabel = XWLabel()
    fileprivate let timeLabel = XWLabel()
    let renewalBtn = XWButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUserNew), name: .updateUserNew, object: nil)
        
        bgView.image = "mine_bg".getImage()
        self.addSubview(bgView)
        
        setbutton.setImage(image: "ic_me_setting",color: UIColor.white)
        self.addSubview(setbutton)
        
        headImageView.setImage(image: "tanshu_user_header_icon")
        self.addSubview(headImageView)
        
        phoneLabel.setText(text: isLogin ? UserInfo.phone : loginFirst)
        phoneLabel.setFont(size: 18, isBold: true)
        self.addSubview(phoneLabel)
        
        nickNameLabel.setText(text: isLogin ? UserInfo.nickname : "xxxxxx")
        nickNameLabel.setTextColor(color: UIColor.white)
        nickNameLabel.setFont(size: 14)
        self.addSubview(nickNameLabel)
        
        renewalView.backgroundColor = UIColor.clear
        renewalView.setBGImage(name: "members_bg")
        self.addSubview(renewalView)
        
        unlockLabel.text = UserInfo.is_vip == "1" ? unlock : lock
        unlockLabel.textColor = UIColor.Theme.brown
        unlockLabel.setFont(size: 16, isBold: true)
        renewalView.addSubview(unlockLabel)
        
        timeLabel.text = UserInfo.is_vip == "1" ? (unlock + "：" + UserInfo.vip_end) : lock
        timeLabel.textColor = UIColor.Theme.brown
        timeLabel.setFont(size: 14)
        renewalView.addSubview(timeLabel)
        
        renewalBtn.setText(text: UserInfo.is_vip == "1" ? renewal : goUnlock)
        renewalBtn.backgroundColor = UIColor.Theme.black
        renewalBtn.setFont(size: 16)
        renewalBtn.setCornerRadius(15)
        renewalView.addSubview(renewalBtn)
        
        bgView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(ScreenW*0.62)
        }
        
        setbutton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(30)
        }
        
        headImageView.snp.makeConstraints { (make) in
            make.top.equalTo(setbutton.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(70)
        }
        
        phoneLabel.snp.makeConstraints { (make) in
            make.top.equalTo(headImageView).offset(10)
            make.left.equalTo(headImageView.snp.right).offset(20)
            make.width.greaterThanOrEqualTo(10)
            make.height.equalTo(20)
        }
        
        nickNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(phoneLabel)
            make.width.greaterThanOrEqualTo(10)
            make.top.equalTo(phoneLabel.snp.bottom).offset(10)
            make.height.equalTo(phoneLabel)
        }
        
        renewalView.snp.makeConstraints { (make) in
            make.centerY.equalTo(bgView.snp.bottom).offset(-20)
            make.left.equalTo(headImageView)
            make.right.equalTo(setbutton)
            make.height.equalTo(70)
        }
        
        renewalBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
        unlockLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalTo(renewalBtn.snp.left).offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(unlockLabel)
            make.top.equalTo(unlockLabel.snp.bottom).offset(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
    }
    
    @objc fileprivate func updateUserNew() {
        
        phoneLabel.setText(text: isLogin ? UserInfo.phone : loginFirst)
        nickNameLabel.setText(text: isLogin ? UserInfo.nickname : "xxxxxx")
        unlockLabel.text = UserInfo.is_vip == "1" ? unlock : lock
        timeLabel.text = UserInfo.is_vip == "1" ? (unlock + "：" + UserInfo.vip_end) : lock
        renewalBtn.setText(text: UserInfo.is_vip == "1" ? renewal : goUnlock)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
