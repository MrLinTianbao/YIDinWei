//
//  CareView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/17.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class CareView: XWView {
    
    var backBlock : (()->Void)?
    var addBlock : (()->Void)?
    
    fileprivate let addPhoneView = AddPhoneView()
    fileprivate let addwechatView = AddWechatView()
    fileprivate let confirmBtn = XWButton()
    
    var phoneNumber = "" {
        didSet{
            addPhoneView.textStr = phoneNumber
        }
    }

    init() {
        super.init(frame: .zero)
        
        let bgView = XWImageView()
        bgView.isUserInteractionEnabled = true
        bgView.image = "tanshu_add_friend_bg".getImage()
        self.addSubview(bgView)
        
        let backImage = XWButton()
        backImage.setImage(image: "white_back")
        backImage.addAction { (sender) in
            self.backBlock?()
        }
        bgView.addSubview(backImage)
        
        let addLabel = XWLabel()
        addLabel.text = addFriends
        addLabel.textColor = UIColor.white
        addLabel.setFont(size: 20, isBold: true)
        bgView.addSubview(addLabel)
        
        let checkLabel = XWLabel()
        checkLabel.text = checkPosition
        checkLabel.textColor = UIColor.white
        checkLabel.setFont(size: 16, isBold: true)
        bgView.addSubview(checkLabel)
        
        let meetLabel = XWLabel()
        meetLabel.text = meetProblem
        meetLabel.textColor = UIColor.white
        meetLabel.setFont(size: 16, isBold: true)
        bgView.addSubview(meetLabel)
        
        let guardianLabel = XWLabel()
        guardianLabel.text = guardian
        guardianLabel.textColor = UIColor.white
        guardianLabel.setFont(size: 16, isBold: true)
        bgView.addSubview(guardianLabel)
        
        addPhoneView.addBlock = {
            self.addBlock?()
        }
        addPhoneView.textStr = phoneNumber
        self.addSubview(addPhoneView)
        
        addwechatView.addAction { (sender) in
            CarePresenter.shareForWechat(type: 0)
        }
        self.addSubview(addwechatView)
        
        confirmBtn.addAction { (sender) in
            self.addFriendAction()
        }
        confirmBtn.setText(text: addFriends)
        confirmBtn.setFont(size: 16,isBold: true)
        confirmBtn.backgroundColor = UIColor.Theme.green
        confirmBtn.setCornerRadius(10)
        confirmBtn.setShadow(offsetW: 0, offsetH: 0)
        self.addSubview(confirmBtn)
        
        bgView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
        
        backImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(isIPhoneX ? 40 : 20)
            make.left.equalToSuperview().offset(10)
            make.width.height.equalTo(30)
        }
        
        addLabel.snp.makeConstraints { (make) in
            make.top.equalTo(backImage.snp.bottom).offset(20)
            make.left.equalTo(backImage.snp.right)
            make.right.equalToSuperview().offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        checkLabel.snp.makeConstraints { (make) in
            make.top.equalTo(addLabel.snp.bottom).offset(10)
            make.left.right.equalTo(addLabel)
            make.height.greaterThanOrEqualTo(10)
        }
        
        meetLabel.snp.makeConstraints { (make) in
            make.top.equalTo(checkLabel.snp.bottom).offset(5)
            make.left.right.equalTo(checkLabel)
            make.height.greaterThanOrEqualTo(10)
        }
        
        guardianLabel.snp.makeConstraints { (make) in
            make.top.equalTo(meetLabel.snp.bottom).offset(5)
            make.left.right.equalTo(meetLabel)
            make.height.greaterThanOrEqualTo(10)
        }
        
        addPhoneView.snp.makeConstraints { (make) in
            make.top.equalTo(guardianLabel.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(120)
        }
        
        addwechatView.snp.makeConstraints { (make) in
            make.top.equalTo(addPhoneView.snp.bottom).offset(50)
            make.left.right.equalTo(addPhoneView)
            make.height.equalTo(50)
        }
        
        confirmBtn.snp.makeConstraints { (make) in
            make.top.equalTo(addwechatView.snp.bottom).offset(50)
            make.centerX.equalTo(addwechatView)
            make.width.equalTo(ScreenW/2)
            make.height.equalTo(40)
        }
        
    }
    
    
    fileprivate func addFriendAction() {
        
        if addPhoneView.text == "" {
            AlertClass.showToat(withStatus: inputPhone)
            return
        }
        
        if addPhoneView.text.count != 11 {
            AlertClass.showToat(withStatus: phoneError)
            return
        }
        
        AlertClass.waiting(isAdd)
        
        CarePresenter.addFriendAction(parameters: ["phone":addPhoneView.text,"style":"0"]) { (json) in
            
            AlertClass.stop()
            AlertClass.setAlertView(msg: waitForValidation, target: self.window?.rootViewController, haveCancel: true) { (alert) in
                
                CarePresenter.shareForFriend(json: json, type: 0)
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
