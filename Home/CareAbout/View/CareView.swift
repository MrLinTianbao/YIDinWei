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
    
    fileprivate let titleLabel = XWLabel()
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
        bgView.image = "addFri_bg".getImage()
        self.addSubview(bgView)
        
        let backImage = XWButton()
        backImage.setImage(image: "white_back")
        backImage.addAction { (sender) in
            self.backBlock?()
        }
        bgView.addSubview(backImage)

        titleLabel.text = addFriends
        titleLabel.setFont(size: 18,isBold: true)
        titleLabel.textColor = UIColor.white
        bgView.addSubview(titleLabel)
        
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
        confirmBtn.backgroundColor = UIColor.Theme.red
        confirmBtn.setCornerRadius(10)
        confirmBtn.setShadow(offsetW: 0, offsetH: 0)
        self.addSubview(confirmBtn)
        
        bgView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(ScreenW*0.73)
        }
        
        backImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(isIPhoneX ? 40 : 20)
            make.left.equalToSuperview().offset(10)
            make.width.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(backImage)
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualTo(10)
            make.height.greaterThanOrEqualTo(10)
        }
        
        addPhoneView.snp.makeConstraints { (make) in
            make.centerY.equalTo(bgView.snp.bottom)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(110)
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
