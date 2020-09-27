//
//  SignInView.swift
//  XunWei
//
//  Created by TiBo's Mac on 2020/8/12.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

import UIKit

class SignInView: XWView {
    
    var backBlock : (()->Void)?
    var agreementBlock : ((String)->Void)?
    
    fileprivate let bgImgeView = XWImageView()
    
    fileprivate let logoImage = XWImageView()
    
    fileprivate let bgView = XWView()
    
    fileprivate let arrowBtn = XWButton()
    
    fileprivate let phoneTF = XWTextField()
    fileprivate let codeTF = XWTextField()
    
    fileprivate let lineView = XWView()
    fileprivate let lineView2 = XWView()
    
    fileprivate let codeBtn = XWButton()
    fileprivate let signInBtn = XWButton()
    
    fileprivate let selectBtn = XWButton()
    fileprivate let tipLabel = XWTextView()
    
    var isSelect = true

    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor.Theme.bgColor
        
        bgImgeView.image = "sign_bg".getImage()
        self.addSubview(bgImgeView)
        
        logoImage.image = "icon".getImage()
        logoImage.setCornerRadius(30)
        self.addSubview(logoImage)
        
        bgView.setCornerRadius(10)
        self.addSubview(bgView)
        
        arrowBtn.setImage(image: "white_back")
        arrowBtn.addAction { (sender) in
            self.backBlock?()
        }
        self.addSubview(arrowBtn)
        
        phoneTF.attributedPlaceholder = inputPhone.setTextFont(color: UIColor.Theme.red.withAlphaComponent(0.5), fontSize: 16, ranStr: inputPhone)
        phoneTF.keyboardType = .numberPad
        phoneTF.borderStyle = .none
        bgView.addSubview(phoneTF)
        
        codeTF.attributedPlaceholder = inputCode.setTextFont(color: UIColor.Theme.red.withAlphaComponent(0.5), fontSize: 16, ranStr: inputCode)
        codeTF.keyboardType = .numberPad
        codeTF.borderStyle = .none
        bgView.addSubview(codeTF)
        
        lineView.backgroundColor = UIColor.Theme.pink
        bgView.addSubview(lineView)
        
        lineView2.backgroundColor = UIColor.Theme.pink
        bgView.addSubview(lineView2)
        
        codeBtn.addAction { (sender) in
            self.sendSMSCode()
        }
        codeBtn.setText(text: getCode)
        codeBtn.setFont(size: 16)
        codeBtn.setCornerRadius(15)
        codeBtn.setTextColor(color: UIColor.Theme.red)
        codeBtn.setborder(size: 1, color: UIColor.Theme.red)
        bgView.addSubview(codeBtn)
        
        signInBtn.setText(text: signIn)
        signInBtn.setFont(size: 16)
        signInBtn.setBGImage(name: "signBtn")
        signInBtn.addAction { (sender) in
            self.signInAction()
        }
        bgView.addSubview(signInBtn)
        
        selectBtn.setBGImage(name: "agree_normal",color: UIColor.Theme.red)
        self.addSubview(selectBtn)
        
        selectBtn.addAction { (sender) in
            self.selectAction()
        }
        
        tipLabel.backgroundColor = UIColor.clear
        tipLabel.attributedText = SignInPresenter.setFontStyle()
        tipLabel.linkTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.Theme.red]
        tipLabel.delegate = self
        tipLabel.setFont(size: 14)
        tipLabel.isEditable = false
        self.addSubview(tipLabel)
        
        bgImgeView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(ScreenW*0.84)
        }
        
        arrowBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(isIPhoneX ? 30 : 20)
            make.left.equalToSuperview().offset(10)
            make.width.height.equalTo(30)
        }
        
        logoImage.snp.makeConstraints { (make) in
            make.top.equalTo(arrowBtn.snp.bottom).offset(RATIO_H(maxNum: 50))
            make.centerX.equalToSuperview()
            make.width.height.equalTo(RATIO_H(maxNum: 60))
        }
        
        bgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(bgImgeView.snp.bottom)
            make.left.equalToSuperview().offset(28)
            make.right.equalToSuperview().offset(-28)
            make.height.equalTo(250)
        }
        
        phoneTF.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(30)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(phoneTF.snp.bottom)
            make.left.right.equalTo(phoneTF)
            make.height.equalTo(1)
        }
        
        codeBtn.snp.makeConstraints { (make) in
            make.right.equalTo(phoneTF)
            make.top.equalTo(lineView.snp.bottom).offset(30)
            make.width.equalTo(120)
            make.height.equalTo(30)
        }
        
        codeTF.snp.makeConstraints { (make) in
            make.right.equalTo(codeBtn.snp.left).offset(-10)
            make.centerY.equalTo(codeBtn)
            make.height.left.equalTo(phoneTF)
        }
        
        lineView2.snp.makeConstraints { (make) in
            make.left.height.equalTo(lineView)
            make.right.equalTo(codeTF)
            make.top.equalTo(codeTF.snp.bottom)
        }
        
        signInBtn.snp.makeConstraints { (make) in
            make.top.equalTo(lineView2.snp.bottom).offset(40)
            make.centerX.equalTo(lineView)
            make.width.bottom.equalToSuperview()
        }
        
        selectBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(bgView.snp.bottom).offset(37.5)
            make.width.height.equalTo(20)
        }
        
        tipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(signInBtn.snp.bottom).offset(30)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(aboutsignInTip.xw_calculateHeigh(withWidth: ScreenW-65, size: 16, lineSpacing: 5))
            make.left.equalTo(selectBtn.snp.right)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func sendSMSCode() {
        
        if phoneTF.text == "" {
            AlertClass.showToat(withStatus: inputPhone)
            return
        }
        
        if phoneTF.text?.count != 11 {
            AlertClass.showToat(withStatus: phoneError)
            return
        }
        
        AlertClass.show()
        
        SignInPresenter.sendSMSCode(parameters: ["phone":phoneTF.text ?? ""], success: {
            
            AlertClass.stop()
            self.codeBtn.xw_countDown(count: 60, enabledColor: UIColor.Theme.red)
        })
        
    }
    
    fileprivate func signInAction() {
        
        if phoneTF.text == "" {
            AlertClass.showToat(withStatus: inputPhone)
            return
        }
        
        if phoneTF.text?.count != 11 {
            AlertClass.showToat(withStatus: phoneError)
            return
        }
        
        if codeTF.text == "" {
            AlertClass.showToat(withStatus: inputCode)
            return
        }
        
        if !isSelect {
            AlertClass.showToat(withStatus: agreeAgreement)
            return
        }
        
        AlertClass.show()
        
        SignInPresenter.signInAction(parameters: ["linkId":"1","deviceId":UserInfo.deviceId,"phone":phoneTF.text!,"code":codeTF.text!]) {
            
            NotificationCenter.default.post(name: .updateUserNew, object: nil)
            NotificationCenter.default.post(name: .updateFriendList, object: nil)
            AlertClass.stop()
            self.backBlock?()
        }
        
    }
    
    @objc fileprivate func selectAction() {
        
        self.isSelect = !self.isSelect
        
        if self.isSelect {
            selectBtn.setBGImage(name: "agree_normal",color: UIColor.Theme.red)
        }else{
            selectBtn.setBGImage(name: "agree_normal",color: UIColor.Theme.lineColor)
        }
    }
    
}

extension SignInView : UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        
        if URL.scheme == "user" || URL.scheme == "privacy" {
            
            self.agreementBlock?(URL.scheme!)
            return true
            
        }
        
        return false
    }
    
}
